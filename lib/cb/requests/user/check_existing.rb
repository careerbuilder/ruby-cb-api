require_relative '../base'

module Cb
  module Requests
    module User
      class CheckExisting < Base

        def endpoint_uri
          Cb.configuration.uri_user_check_existing
        end

        def http_method
          :post
        end

        def body
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <Email>#{@args[:email]}</Email>
              <Password>#{@args[:password]}</Password>
              <Test>#{(@args[:test] || false).to_s}</Test>
            </Request>
          eos
        end

      end
    end
  end
end
