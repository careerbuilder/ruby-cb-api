require_relative '../base'

module Cb
  module Requests
    module Company
      class Find < Base

        def endpoint_uri
          Cb.configuration.uri_company_find
        end

        def http_method
          :get
        end

        def query
          {
            :CompanyDID => @args[:did],
            :HostSite=> Cb.configuration.host_site
          }
        end

      end
    end
  end
end
