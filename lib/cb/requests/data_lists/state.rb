require_relative '../base'

module Cb
  module Requests
    module State
      class Get < Base
        def base_uri
          'https://www.careerbuilder.com'
        end

        def endpoint_uri
          Cb.configuration.uri_state_list
        end

        def http_method
          :get
        end

        def query
          {
              countryCode: args[:country_code],
              outputjson: true
          }
        end
      end
    end
  end
end
