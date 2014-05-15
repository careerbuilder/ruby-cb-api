require_relative '../base'

module Cb
  module Requests
    module User
      class Retrieve < Base

        private

        def set_uri_endpoint
          Cb.configuration.uri_user_retrieve
        end

        def set_http_method
          :post
        end

        def set_response_object
          Cb::Responses::User::Retrieve
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
              <ExternalID>#{args[:external_id]}</ExternalID>
              <Test>#{(args[:test] || false).to_s}</Test>
            </Request>
          eos
        end

      end
    end
  end
end