require_relative '../base'

module Cb
  module Requests
    module EmailSubscription
      class Retrieve < Base

        def endpoint_uri
          Cb.configuration.uri_subscription_retrieve
        end

        def http_method
          :get
        end

        def query
          {
            ExternalID: @args[:external_id],
            HostSite: @args[:host_site]
          }
        end

      end
    end
  end
end
