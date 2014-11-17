require_relative '../base'

module Cb
  module Requests
    module Resumes
      class LanguageCodes < Base
        def endpoint_uri
          Cb.configuration.uri_resume_language_codes
        end

        def http_method
          :get
        end

        def headers
          {
              'DeveloperKey' => Cb.configuration.dev_key,
              'Content-Type' => 'application/json'
          }
        end
      end
    end
  end
end
