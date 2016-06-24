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
require 'faraday'
require 'faraday_middleware'
require 'middleware/errors'
require 'middleware/timing'
require 'middleware/developerkey'
require 'observer'

module Cb
  module Utils
    class Api
      def self.instance
        Cb::Utils::Api.new
      end

      def initialize
        @connection = Faraday.new base_uri, connection_options do |builder|
          builder.use(Middleware::Timing, { observers: observers })
          builder.response :cb_errors
          builder.response :default_response
          builder.request :cb_devkey

          builder.use ::FaradayMiddleware::ParseXml,  :content_type => /\bxml$/
          builder.use ::FaradayMiddleware::ParseJson, :content_type => /\bjson$/

          builder.use :gzip
          builder.adapter Cb.configuration.faraday_adapter
        end
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
        response = execute_http_request(http_method, uri, path, options)
        set_api_error(response.body)
        response.body
      end

      def execute_http_request(http_method, uri, path, options = {})
        (original_url, @connection.url_prefix) = @connection.url_prefix, uri if uri
        @connection.url_prefix = uri if uri
        request = @connection.build_request(http_method) do |req|
          req.url(path)
          req.headers.update(options[:headers]) if options.include? :headers
          req.body = options[:body] if options.include? :body
          req.params = query_params(options[:query])
        end
        response = @connection.builder.build_response(@connection, request)
        @connection.url_prefix = original_url if uri
        response
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

      def query_params(params={})
        {
          'developerkey' => Cb.configuration.dev_key,
          'outputjson' => Cb.configuration.use_json.to_s
        }.merge! params.to_h
      end

      def connection_options
        {
          request: {
            timeout: Cb.configuration.time_out,
            open_timeout: Cb.configuration.time_out
          }
        }
      end

      def observers
        observers = Cb.configuration.observers
        observers << Cb::Utils::ConsoleObserver.new if Cb.configuration.debug_api && !Cb.configuration.observers.include?(Cb::Utils::ConsoleObserver)
        observers
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
        snake_case(api_hash_key)
      end

      def snake_case(input)
        return input.downcase if input.match(/\A[A-Z]+\z/)
        input.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z])([A-Z])/, '\1_\2').
        downcase
      end

      def base_uri
        Cb.configuration.base_uri
      end
    end
  end
end
