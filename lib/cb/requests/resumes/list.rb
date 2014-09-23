module Requests
  module Resumes
    class List < Base
      def endpoing_uri
        Cb.configuration.uri_resume_list
      end

      def http_method
        :get
      end

      def query
        {
            DeveloperKey: Cb.configuration.dev_key,
            HostSite: Cb.configuration.host_site,
            OAuthToken: args[:oauth_token]
        }
      end
    end
  end
end