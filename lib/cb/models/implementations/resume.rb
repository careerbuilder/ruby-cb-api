module Cb
  module Models
    class Resume < ApiResponseModel
      attr_accessor :user_identifier

      def set_model_properties
        args = api_response
        @user_identifier = args['userIdentifier']
      end

      def required_fields
        ['userIdentifier']
      end
    end
  end
end
