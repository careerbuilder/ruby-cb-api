module Cb
  module Models
    class CountryCode < ApiResponseModel
      attr_accessor :code

      def set_model_properties
        @code = api_response['CountryCode']
      end

      def required_fields
        ['CountryCode']
      end
    end
  end
end