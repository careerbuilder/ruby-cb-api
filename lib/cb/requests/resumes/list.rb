require_relative '../base'

module Cb
  module Requests
    module Resumes
      class List < Base
        def endpoint_uri
          Cb.configuration.uri_resume_list
        end

        def http_method
          :get
        end

        def query
          {
              HostSite: args[:host_site] || Cb.configuration.host_site,
              OAuthToken: args[:oauth_token]
          }
        end
      end
    end
  end
end
