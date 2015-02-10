module Cb
  module Responses

    class Errors
      attr_reader :parsed

      def initialize(raw_response_hash, raise_on_error = true)
        @response     = raw_response_hash
        @should_raise = raise_on_error
        @parsed       = parsed_errors
      end

      private
      attr_reader :response, :should_raise

      def parsed_errors
        return Array.new unless response.respond_to?(:map)
        errors = response.map { |key, value| parsed_error(key, value) }.flatten
        raise ApiResponseError.new(errors.join(',')) if errors.any? && should_raise
        errors
      end

      def parsed_error(key, value)
        if hashy_errors?(key, value)
          value.values
        elsif error_array?(key, value)
          value
        else
          Array.new
        end
      end

      def hashy_errors?(key, value)
        key.downcase == 'errors' && value.is_a?(Hash)
      end

      def error_array?(key, value)
        (key.downcase == 'error' || key.downcase == 'errors') && value.is_a?(Array)
      end

      def method_missing(method, *args, &block)
        parsed.send(method, *args, &block)
      end
    end

  end
end
