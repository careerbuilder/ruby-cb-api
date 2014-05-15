require_relative '../base'

module Cb
  module Requests
    module User
      class CheckExisting < Base

        private

        def set_uri_endpoint
          Cb.configuration.uri_user_check_existing
        end

        def set_http_method
          :post
        end

        def set_response_object
          Cb::Responses::User::CheckExisting
        end

        def set_query(args)
          nil
        end

        def set_headers(args)
          nil
        end

        def set_body(args)
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <Email>#{args[:email]}</Email>
              <Password>#{args[:password]}</Password>
              <Test>#{(args[:test] || false).to_s}</Test>
            </Request>
          eos
        end

      end
    end
  end
end