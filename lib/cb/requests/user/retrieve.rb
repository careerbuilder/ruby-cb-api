require_relative '../base'

module Cb
  module Requests
    module User
      class Retrieve < Base

        def endpoint_uri
          Cb.configuration.uri_user_retrieve
        end

        def http_method
          :post
        end

        def body
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>#{@args[:external_id]}</ExternalID>
              <Test>#{test?}</Test>
            </Request>
          eos
        end

      end
    end
  end
end
