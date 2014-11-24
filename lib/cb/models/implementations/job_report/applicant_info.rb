module Cb
  module Models
    class ApplicantInfo < ApiResponseModel
      attr_accessor :date_application_viewed, :date_applied, :user_attached_cover_letter

      def set_model_properties
        @date_application_viewed        = api_response['DateApplicationViewed']
        @date_applied                   = api_response['DateApplied']
        @user_attached_cover_letter     = api_response['CoverLetterAttached']
      end

      def required_fields
        %w(DateApplicationViewed DateApplied CoverLetterAttached)
      end

    end
  end
end
