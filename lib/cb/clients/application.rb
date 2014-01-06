module Cb
  module Clients
    class Application
      class << self
        def get(criteria)
          response_hash = api_client.cb_get uri(criteria), headers: headers
          Responses::Application::Get.new(response_hash)
        end

        private

        def uri(criteria)
          Cb.configuration.uri_application.sub ':did', criteria.did
        end

        def headers
          {
            DeveloperKey: Cb.configuration.dev_key,
            HostSite: Cb.configuration.host_site
          }
        end

        def api_client
          Cb::Utils::Api.new
        end
      end
    end
  end
end
