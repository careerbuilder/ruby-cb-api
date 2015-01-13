require_relative '../base'

module Cb
  module Requests
    module Resumes
      class Post < Base
        def endpoint_uri
          Cb.configuration.uri_resume_post
        end

        def http_method
          :post
        end

        def body
          {
            desiredJobTitle: args[:desired_job_title],
            privacySetting: args[:privacy_setting],
            resumeFileData: args[:resume_file_data],
            resumeFileName: args[:resume_file_name],
            hostSite: args[:host_site]
          }
        end

        def headers
          {
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json',
            'Authorization' => three_scale_bearer_token
          }
        end
        
        def three_scale_bearer_token
          "Bearer #{args[:three_scale_token]}"
        end
      end
    end
  end
end
