require_relative '../base'

module Cb
  module Requests
    module JobReport
      class Get < Base

        def endpoint_uri
          Cb.configuration.uri_job_report.sub ':job_did', @args[:job_did].to_s
        end

        def http_method
          :get
        end

        def headers
          {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          }
        end

        def query
          {
              UserOauthToken: args[:user_oauth_token]
          }
        end

      end
    end
  end
end
