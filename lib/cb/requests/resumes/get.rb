require_relative '../base'

module Cb
  module Requests
    module Resumes
      class Get < Base
        def endpoint_uri
          Cb.configuration.uri_resume_get.gsub(':resume_hash', args[:resume_hash].to_s)
        end

        def http_method
          :get
        end

        def query
          {
            externalUserID: args[:external_user_id]
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
