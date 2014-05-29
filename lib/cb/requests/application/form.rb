require_relative '../base'

module Cb
  module Requests
    module Application
      class Form < Base

        def endpoint_uri
          Cb.configuration.uri_application_form.sub ':did', @args[:application_did].to_s
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

      end
    end
  end
end
