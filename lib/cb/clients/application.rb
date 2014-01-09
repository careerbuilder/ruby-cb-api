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

        def update(criteria)
          response cb_call(:put, criteria)
        end

        private

        def cb_call(http_method, criteria)
          options = { headers: headers }
          if [:post, :put].include? http_method
            options[:body] = criteria.to_json
          end

          uri = uri(http_method, criteria)
          api_client.method(:"cb_#{http_method}").call uri, options
        end

        def response(response_hash)
          Responses::Application.new response_hash
        end

        def uri(http_method, criteria)
          did = http_method == :get ? criteria.application_did : criteria.job_did
          Cb.configuration.uri_application.sub ':did', did
        end

        def headers
          {
            'DeveloperKey' => Cb.configuration.dev_key,
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json'
          }
        end

        def api_client
          Cb::Utils::Api.new
        end
      end
    end
  end
end
