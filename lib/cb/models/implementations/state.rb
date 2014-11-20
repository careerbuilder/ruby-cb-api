module Cb
  module Models
    class State < ApiResponseModel
      attr_accessor :key, :value

      def set_model_properties
        @key = api_response['StateId']
        @value = api_response['StateName']

      end

      def required_fields
        ['StateId', 'StateName']
      end
    end
  end
end
