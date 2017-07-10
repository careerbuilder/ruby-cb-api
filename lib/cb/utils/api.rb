# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'httparty'
require 'observer'

module Cb
  module Utils
    class Api
      include HTTParty, Observable

      base_uri 'https://api.careerbuilder.com'

      def self.instance(headers: {})
        api = Cb::Utils::Api.new(headers: headers)
        Cb.configuration.observers.each do |class_name|
          api.add_observer(class_name.new)
        end
        if Cb.configuration.debug_api && !Cb.configuration.observers.include?(Cb::Utils::ConsoleObserver)
          api.add_observer(Cb::Utils::ConsoleObserver.new)
        end
        api
      end

      def initialize(headers: {})
        self.class.default_params developerkey: Cb.configuration.dev_key,
                                  outputjson: Cb.configuration.use_json.to_s

        self.class.default_timeout Cb.configuration.time_out
        h = { 'developerkey' => Cb.configuration.dev_key }
        h.merge! ({ 'accept-encoding' => 'deflate, gzip' }) unless Cb.configuration.debug_api
        h.merge! headers
        self.class.headers(h)
      end

      def cb_get(path, options = {}, &block)
        timed_http_request(:get, nil, path, options, &block)
      end

      def cb_post(path, options = {}, &block)
        timed_http_request(:post, nil, path, options, &block)
      end

      def cb_put(path, options = {}, &block)
        timed_http_request(:put, nil, path, options, &block)
      end

      def cb_delete(path, options = {}, &block)
        timed_http_request(:delete, nil, path, options, &block)
      end

      def timed_http_request(http_method, uri, path, options = {}, &block)
        api_caller = find_api_caller(caller)
        response = nil
        start_time = Time.now.to_f
        cb_event(:"cb_#{ http_method }_before", path, options, api_caller, response, 0.0, &block)
        begin
          response = execute_http_request(http_method, uri, path, options)
        ensure
          cb_event(:"cb_#{ http_method }_after", path, options, api_caller, response, Time.now.to_f - start_time, &block)
        end
        validate_response(response)
      end

      def execute_http_request(http_method, uri, path, options = {})
        self.class.base_uri(uri || Cb.configuration.base_uri)
        self.class.method(http_method).call(path, options)
      end

      def append_api_responses(obj, resp)
        #As of ruby 2.2 nil is frozen so stop monkey patching it please -jyeary
        if obj.nil? && obj.frozen?
          obj = Cb::Utils::NilResponse.new
        end
        meta_class = ensure_non_nil_metavalues(obj)

        resp.each do |api_key, api_value|
          meta_name = format_hash_key(api_key)
          unless meta_name.empty?
            if meta_name == 'errors' && api_value.is_a?(Hash)
              api_value = api_value.values
            elsif meta_name == 'error' && api_value.is_a?(String)
              # this is a horrible hack to get consistent object.cb_response.errors behavior for the client
              meta_name = 'errors'
              api_value = [api_value]
            elsif self.class.is_numeric?(api_value)
              api_value = api_value.to_i
            end

            meta_class.class.send(:attr_reader, meta_name)
            meta_class.instance_variable_set(:"@#{meta_name}", api_value)
          end
        end
        obj.class.send(:attr_reader, 'api_error')
        obj.instance_variable_set(:@api_error, @api_error)

        obj.class.send(:attr_reader, 'cb_response')
        obj.instance_variable_set(:@cb_response, meta_class)
        obj
      end

      def self.criteria_to_hash(criteria)
        params = {}
        if criteria.respond_to?(:instance_variables)
          criteria.instance_variables.each do |var|
            var_name = var.to_s
            var_name.slice!(0)
            var_name_hash_safe = camelize(var_name)
            params["#{var_name_hash_safe}"] = criteria.instance_variable_get(var)
          end
        end
        params
      end

      def self.is_numeric?(obj)
        true if Float(obj) rescue false
      end

      private

      def find_api_caller(call_list)
        filename_regex = /.*\.rb/
        linenum_regex = /:.*:in `/
        filename, method_name = call_list.find { |l| use_this_api_caller?(l[filename_regex]) }[0..-2].split(linenum_regex)
        simplified_filename = filename.include?('/lib/') ? filename[/\/lib\/.*/] : filename
        simplified_filename = simplified_filename.include?('/app/') ? simplified_filename[/\/app\/.*/] : simplified_filename
        { file: simplified_filename, method: method_name }
      end

      def use_this_api_caller?(calling_file)
        (calling_file == __FILE__ || calling_file.include?('/lib/cb/client.rb')) ? false : true
      end

      def validate_response(response)
        validated_response = ResponseValidator.validate(response)
        set_api_error(validated_response)
        validated_response
      end

      def api_call_model(api_call_type, path, options, api_caller, response, time_elapsed)
        Cb::Models::ApiCall.new(api_call_type, path, options, api_caller, response, time_elapsed)
      end

      def cb_event(api_call_type, path, options, api_caller, response, time_elapsed, &block)
        call_model = api_call_model(api_call_type, path, options, api_caller, response, time_elapsed)
        block.call(call_model) if block_given?
        changed(true)
        notify_observers(call_model)
      end

      def ensure_non_nil_metavalues(obj)
        if obj.respond_to?('cb_response') && !obj.cb_response.nil?
          obj.cb_response
        else
          Cb::Utils::MetaValues.new
        end
      end

      def self.camelize(input)
        input.sub!(/^[a-z\d]*/) { $&.capitalize }
        input.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{Regexp.last_match(2).capitalize}" }.gsub('/', '::')
      end

      def set_api_error(validated_response)
        @api_error = validated_response.keys.empty?
      end

      def format_hash_key(api_hash_key)
        return '' unless api_hash_key.respond_to?(:snakecase)
        api_hash_key.snakecase
      end
    end
  end
end
