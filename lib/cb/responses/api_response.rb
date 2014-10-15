require 'forwardable'

module Cb
  module Responses

    class ApiResponse
      extend Forwardable
      delegate [:timing, :errors] => :metadata
      delegate :[] => :response

      attr_reader :models, :response
      alias_method :model, :models

      def initialize(raw_response_hash)
        set_response_variable(raw_response_hash)
        @metadata = extract_metadata
        @models   = validated_models
      end

      protected
      attr_reader :metadata

      def extract_models
        raise NotImplementedError.new(__method__)
      end

      def validate_api_hash
        raise NotImplementedError.new(__method__)
      end

      def hash_containing_metadata
        raise NotImplementedError.new(__method__)
      end

      def has_service_unavailable_indicator(error_message)
        raise NotImplementedError.new(__method__)
      end

      def raise_on_timing_parse_error
        true
      end
      def required_response_field(field_name, parent_hash)
        raise ArgumentError.new("field_name can't be nil!")  if field_name.nil?
        raise ArgumentError.new("parent_hash can't be nil!") if parent_hash.nil?
        raise ExpectedResponseFieldMissing.new(field_name) unless parent_hash.has_key?(field_name)
      end

      private

      def set_response_variable(response_hash)
        should_raise = response_hash.nil? || response_hash.empty?
        raise ApiResponseError.new('Response is empty!') if should_raise
        @response = response_hash
      end

      def response_is_service_unavailable(error_message)
        raise ServiceUnavailableError.new(error_message) if has_service_unavailable_indicator(error_message)
      end

      def extract_metadata
        Metadata.new(hash_containing_metadata, raise_on_timing_parse_error) unless hash_containing_metadata.nil?
      rescue ApiResponseError => error
        unless response_is_service_unavailable(error.message)
          raise error
      end
      end

      def validated_models
        validate_api_hash
        extract_models
      end
    end

  end
end
