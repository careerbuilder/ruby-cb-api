module Cb
  module Responses
    class ResumeDocument < ApiResponse
      attr_accessor :resume_id, :desired_job_title, :privacy_setting, :resume_file_data, :resume_file_name, :host_site

      def set_model_properties
        @resume_id = api_response['resumeID']
        @desired_job_title = api_response['desiredJobTitle']
        @privacy_setting = api_response['privacySetting']
        @resume_file_data = api_response['resumeFileData']
        @resume_file_name = api_response['resumeFileName']
        @host_site = api_response['hostSite']
      end

      def required_fields
        ['resumeID']
      end
    end
  end
end
