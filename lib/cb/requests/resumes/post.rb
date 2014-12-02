require_relative '../base'

module Cb
  module Requests
    module Resumes
      class Post < Base
        def endpoint_uri
          Cb.configuration.uri_resume_post.gsub(':resume_hash', args[:resume_hash].to_s)
        end

        def http_method
          :post
        end

        def body
          {
            desiredJobTitle: args[:desired_job_title],
            privacySetting: args[:privacy_setting],
            userIdentifier: args[:user_identifier],
            binary_data: args[:binary_data]
          }
        end

        def headers
          {
            'DeveloperKey' => Cb.configuration.dev_key,
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json'
          }
        end
      end
    end
  end
end