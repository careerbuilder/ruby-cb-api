module Cb
  module Requests
    module DataLists
      class EducationCodes < Base
        def endpoint_uri
          Cb.configuration.uri_resume_education
        end

        def http_method
          :get
        end

        def headers
          {
            'DeveloperKey' => Cb.configuration.dev_key,
            'Content-Type' => 'application/json',
            'CountryCode' => args['country_code'] ||= 'US',
          }
        end
      end
    end
  end
end
