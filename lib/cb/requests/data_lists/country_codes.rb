require_relative '../base'

module Cb
  module Requests
    module DataLists
      class CountryCodes < Base
        def endpoint_uri
          Cb.configuration.uri_country_codes
        end

        def http_method
          :get
        end

        def headers
          {
            'DeveloperKey' => Cb.configuration.dev_key,
            'Content-Type' => 'application/xml'
          }
        end
      end
    end
  end
end
