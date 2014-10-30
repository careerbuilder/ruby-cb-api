require_relative '../base'

module Cb
  module Requests
    module Recommendations
      class Resume < Base

        def endpoint_uri
          Cb.configuration.uri_recommendation_for_resume.sub(':resume_hash', @args[:resume_hash].to_s)
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
            :externalID => args[:external_user_id],
            :countLimit => args[:countLimit] || 25
          }
        end

      end
    end
  end
end
