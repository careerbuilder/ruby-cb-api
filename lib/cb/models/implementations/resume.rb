module Cb
  module Models
    class Resume < ApiResponseModel
      attr_accessor :user_identifier, :resume_hash

      def set_model_properties
        args = api_response
        @user_identifier = args['userIdentifier']
        @resume_hash = args['resumeHash']
      end

      def required_fields
        ['userIdentifier']
      end
    end
  end
end
