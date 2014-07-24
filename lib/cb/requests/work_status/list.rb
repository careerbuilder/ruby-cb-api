require_relative '../base'

module Cb
  module Requests
    module WorkStatus
      class List < Base

        def endpoint_uri
          Cb.configuration.uri_work_status_list
        end

        def http_method
          :get
        end

        def query
          {
            HostSite: @args[:host_site]
          }
        end

      end
    end
  end
end
