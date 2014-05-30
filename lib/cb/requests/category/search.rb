require_relative '../base'

module Cb
  module Requests
    module Category
      class Search < Base

        def endpoint_uri
          Cb.configuration.uri_job_category_search
        end

        def http_method
          :get
        end

        def query
          {
            CountryCode: @args[:host_site]
          }
        end

      end
    end
  end
end
