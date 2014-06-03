require_relative '../base'

module Cb
  module Requests
    module Education
      class Get < Base

        def endpoint_uri
          Cb.configuration.uri_education_code
        end

        def http_method
          :get
        end

        def query
          {
            CountryCode: @args[:country_code]
          }
        end

      end
    end
  end
end
