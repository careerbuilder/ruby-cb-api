require_relative '../base'

module Cb
  module Requests
    module User
      class TemporaryPassword < Base

        private

        def set_uri_endpoint
          Cb.configuration.uri_user_temp_password
        end

        def set_http_method
          :get
        end

        def set_response_object
          Cb::Responses::User::TemporaryPassword
        end

        def set_query(args)
          {
              'ExternalID' => args[:external_id]
          }
        end

        def set_headers(args)
          nil
        end

        def set_body(args)
          nil
        end

      end
    end
  end
end