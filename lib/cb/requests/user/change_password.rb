require_relative '../base'

module Cb
  module Requests
    module User
      class ChangePassword < Base

        def endpoint_uri
          Cb.configuration.uri_user_change_password
        end

        def http_method
          :post
        end

        def body
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>#{args[:external_id]}</ExternalID>
              <Test>#{test?}</Test>
              <OldPassword>#{args[:old_password]}</OldPassword>
              <NewPassword>#{args[:new_password]}</NewPassword>
            </Request>
          eos
        end

      end
    end
  end
end
