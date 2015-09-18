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
require 'cb/models/api_info'

require 'httparty'
require 'observer'

module CB
  module Client
    class MissingParams < StandardError; end

    class Base
      include HTTParty, Observable
      base_uri 'https://api.careerbuilder.com'
      DEFAULT_TIMEOUT = 15

      attr_reader :default_params, :headers, :timeout

      def initialize(config = {})
        modify_base_uri(config[:uri] || CB.configuration.uri)
        set_default_params(config[:default_params])
        set_headers(config[:headers])
        set_timeout(config[:timeout])
        tack_on_observers(config[:observers] || CB.configuration.observers)
      end

      private

      [:get, :post, :put, :delete, :head].each do |verb|
        define_method(verb) do |path, opts|
          start_time = Time.now.to_f
          opts.merge!(default_params: @default_params, headers: @headers, timeout: @timeout)
          before_request(self, verb, path, opts)
          begin
            resp = self.class.public_send(verb, path, opts)
          ensure
            after_request(self, verb, path, opts, resp, Time.now.to_f - start_time)
          end
          resp
        end
      end

      def modify_base_uri(uri)
        self.class.base_uri(uri) if uri
      end

      def set_default_params(params)
        @default_params ||= {}
        @default_params = shallow_symbolize_hash_keys(params) if params.is_a?(Hash)
        unless @default_params.has_key?(:developerkey) || CB.configuration.dev_key == CB::Config::DEV_KEY_DEFAULT
          @default_params.merge!(developerkey: CB.configuration.dev_key)
        end
        fail MissingParams.new(:developerkey) unless @default_params.has_key?(:developerkey)
      end

      def set_headers(h)
        @headers ||= {}
        @headers = shallow_stringify_hash_keys(h) if h.is_a?(Hash)
      end

      def set_timeout(t)
        @timeout ||= DEFAULT_TIMEOUT
        @timeout = t if t && (t.is_a?(Fixnum) || t.is_a?(Float))
      end

      def shallow_symbolize_hash_keys(h)
        h.inject({}) { |memo, (k, v)| memo[k.to_sym] = v; memo }
      end

      def shallow_stringify_hash_keys(h)
        h.inject({}) { |memo, (k, v)| memo[k.to_s] = v; memo }
      end

      def tack_on_observers(observers)
        if observers.is_a?(Array)
          observers.each do |klass|
            add_observer(klass)
          end
        end
      end

      def generate_api_info(stage, verb, path, options, klass, response, elapsed_time)
        api_caller = [klass.class.name, verb.upcase, path].join(';')
        name = :"cb_#{ verb }_#{ stage }"
        CB::Models::APIInfo.new(name, path, options, api_caller, response, elapsed_time)
      end

      def before_request(klass, verb, path, options)
        api_event(generate_api_info('before', verb, path, options, klass, nil, 0.0))
      end

      def after_request(klass, verb, path, options, response, elapsed_time)
        api_event(generate_api_info('after', verb, path, options, klass, response, elapsed_time))
      end

      def api_event(api_info)
        changed
        notify_observers(api_info)
      end

      def query_plus_host_site(host_site, query = {})
        { hostsite: (host_site.nil? || host_site.empty?) ? CB.configuration.host_site : host_site }.merge(query)
      end
    end
  end
end
