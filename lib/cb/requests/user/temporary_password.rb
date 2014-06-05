require_relative '../base'

module Cb
  module Requests
    module User
      class TemporaryPassword < Base

        def endpoint_uri
          Cb.configuration.uri_user_temp_password
        end

        def http_method
          :get
        end

        def query
          {
              'ExternalID' => args[:external_id]
          }
        end

      end
    end
  end
end
