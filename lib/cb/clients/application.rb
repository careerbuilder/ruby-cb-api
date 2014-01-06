module Cb
  module Clients
    class Application
      class << self

        def get(criteria)
          response cb_call(:get, criteria)
        end

        def create(criteria)
          response cb_call(:post, criteria)
        end

        private

        def cb_call(http_method, criteria)
          options = { headers: headers }
          if [:post, :put].include? http_method
            options[:body] = criteria.to_xml
          end

          api_client.method(:"cb_#{http_method}").call uri(criteria), options
        end

        def response(response_hash)
          Responses::Application.new response_hash
        end

        def uri(criteria)
          Cb.configuration.uri_application.sub ':did', criteria.did.to_s
        end

        def headers
          {
            'DeveloperKey' => Cb.configuration.dev_key,
            'HostSite' => Cb.configuration.host_site
          }
        end

        def api_client
          Cb::Utils::Api.new
        end
      end
    end
  end
end
