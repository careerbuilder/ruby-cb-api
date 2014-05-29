require_relative '../base'

module Cb
  module Requests
    module User
      class Delete < Base

        def endpoint_uri
          Cb.configuration.uri_user_delete
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
              <Password>#{@args[:password]}</Password>
            </Request>
          eos
        end

      end
    end
  end
end
