require 'httparty'
require 'observer'

module Cb
  module Utils
    class Api
      include HTTParty, Observable

      base_uri 'https://api.careerbuilder.com'

      def self.instance
        api = Cb::Utils::Api.new
        Cb.configuration.observers.each do |class_name|
          api.add_observer(class_name.new)
        end
        if Cb.configuration.debug_api && !Cb.configuration.observers.include?(Cb::Utils::ConsoleObserver)
          api.add_observer(Cb::Utils::ConsoleObserver.new)
        end
        api
      end

      def initialize
        self.class.default_params :developerkey => Cb.configuration.dev_key,
                                  :outputjson => Cb.configuration.use_json.to_s

        self.class.default_timeout Cb.configuration.time_out
        self.class.headers.merge! ({'developerkey' => Cb.configuration.dev_key})
        self.class.headers.merge! ({'accept-encoding' => 'deflate, gzip'}) unless Cb.configuration.debug_api
      end

      def cb_get(path, options={}, callback_method = nil)
        self.class.base_uri Cb.configuration.base_uri
        cb_event(:cb_get_before, path, options, nil, callback_method)
        response = self.class.get(path, options)
        cb_event(:cb_get_after, path, options, response, callback_method)
        validate_response(response)
      end

      def cb_post(path, options={}, callback_method = nil)
        self.class.base_uri Cb.configuration.base_uri
        cb_event(:cb_post_before, path, options, nil, callback_method)
        response = self.class.post(path, options)
        cb_event(:cb_post_after, path, options, response, callback_method)
        validate_response(response)
      end

      def cb_put(path, options={}, callback_method = nil)
        self.class.base_uri Cb.configuration.base_uri
        cb_event(:cb_put_before, path, options, nil, callback_method)
        response = self.class.put(path, options)
        cb_event(:cb_put_after, path, options, response, callback_method)
        validate_response(response)
      end

      def append_api_responses(obj, resp)
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
        params = Hash.new
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

      def validate_response(response)
        validated_response = ResponseValidator.validate(response)
        set_api_error(validated_response)
        validated_response
      end

      def api_call_model(api_call_type, path, options, response)
        Cb::Models::ApiCall.new(api_call_type, path, options, response)
      end

      def cb_event(api_call_type, path, options, response, callback_method)
        call_model = api_call_model(api_call_type, path, options, response)
        callback_method.call(call_model) unless callback_method.nil?
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
        input.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$2.capitalize}" }.gsub('/', '::')
      end

      def set_api_error(validated_response)
        @api_error = validated_response.keys.empty?
      end

      def format_hash_key(api_hash_key)
        return String.new unless api_hash_key.respond_to?(:snakecase)
        api_hash_key.snakecase
      end
    end
  end
end
