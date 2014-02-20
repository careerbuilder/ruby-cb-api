module Cb
  module Models
    class Application < ApiResponseModel
      class Resume < ApiResponseModel
        attr_accessor :external_resume_id, :resume_file_name, :resume_data, :resume_extension, :resume_title

        protected

        def required_fields
          %w(ExternalResumeID)
        end

        def set_model_properties
          @external_resume_id = api_response['ExternalResumeID']
          @resume_file_name = api_response['ResumeFileName']
          @resume_data = api_response['ResumeData']
          @resume_extension = api_response['ResumeExtension']
          @resume_title = api_response['ResumeTitle']
        end

      end
    end
  end
end
