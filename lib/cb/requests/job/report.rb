module  Cb
  module Requests
    module Job
      class Report < Base

        def endpoint_uri
          Cb.configuration.uri_report_job
        end

        def http_method
          :post
        end

        def body
          {
              jobDID: args[:jobDID],
              userID: args[:userID],
              reportType: args[:reportType],
              comments: args[:comments],
              ipAddress: args[:ipAddress]
          }.to_json
        end

      end
    end
  end
end