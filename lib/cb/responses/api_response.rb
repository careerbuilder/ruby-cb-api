require 'forwardable'

module Cb
  module Responses

    class ApiResponse
      extend Forwardable
      delegate [:timing, :errors] => :metadata
      delegate :[] => :response

      attr_reader :models, :response

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

      def metadata_containing_node
        raise NotImplementedError.new(__method__)
      end

      def required_response_field(field_name, parent_hash)
        raise ArgumentError.new("field_name can't be nil!")  if field_name.nil?
        raise ArgumentError.new("parent_hash can't be nil!") if parent_hash.nil?
        raise ExpectedResponseFieldMissing.new(field_name) unless parent_hash.has_key?(field_name)
      end

      private

      def set_response_variable(response_hash)
        raise ApiResponseError.new('Response is empty!') if response_hash.nil? || response_hash.empty?
        @response = response_hash
      end

      def extract_metadata
        Metadata.new(metadata_containing_node)
      end

      def validated_models
        validate_api_hash
        extract_models
      end
    end

  end
end
