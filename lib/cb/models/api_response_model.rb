module Cb
  module Models
    class ApiResponseModel

      attr_accessor :api_response

      def initialize(response={})
        @api_response = response
        validate_api_response
        set_model_properties
      end

      protected

      def required_fields
        # return an array of hash keys to check for in your api hash
        raise NotImplementedError.new(__method__)
      end

      def set_model_properties
        # do whatever work you need to do to set up the attributes on your model
        raise NotImplementedError.new(__method__)
      end

      private

      def validate_api_response
        missing_fields  = required_fields.map { |field| field unless @api_response.has_key?(field) }.compact
        raise ExpectedResponseFieldMissing.new(missing_fields.join(' ')) unless missing_fields.empty?
      end

    end
  end
end
