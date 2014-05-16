require_relative '../base'

module Cb
  module Requests
    module User
      class ChangePassword < Base

        private

        def set_uri_endpoint
          Cb.configuration.uri_user_change_password
        end

        def set_http_method
          :post
        end

        def set_response_object
          Cb::Responses::User::ChangePassword
        end

        def set_body(args)
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>#{args[:external_id]}</ExternalID>
              <Test>#{(args[:test] || false).to_s}</Test>
              <OldPassword>#{args[:old_password]}</OldPassword>
              <NewPassword>#{args[:new_password]}</NewPassword>
            </Request>
          eos
        end

      end
    end
  end
end