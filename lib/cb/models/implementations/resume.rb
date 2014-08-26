module Cb
  module Models
    class Resume < ApiResponseModel
      attr_accessor :user_identifier

      def set_model_properties
        @user_identifier = args['userIdentifier']
      end
    end
  end
end
