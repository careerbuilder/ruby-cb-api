require 'forwardable'

module Cb
  module Responses

    class Errors
      extend Forwardable
      delegate :[] => :errors

      def initialize(raw_response_hash)
        @response = raw_response_hash
        @errors = parsed_errors
      end

      def error?
        errors.any?
      end

      private
      attr_reader :response, :errors

      def parsed_errors
        return Array.new unless response.respond_to?(:map)
        errors = response.map { |key, value| parsed_error(key, value) }.flatten
        raise ApiResponseError.new(errors.to_s) if errors.any?
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
        key.downcase == 'error' && value.is_a?(Array)
      end
    end

  end
end
