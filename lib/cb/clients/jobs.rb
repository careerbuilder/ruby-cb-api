require 'json'

module Cb
  module Clients
    class Jobs
      class << self
        def search(args)
          response = api_client.cb_get(Cb.configuration.uri_job_search, query: args)
          Cb::Responses::Jobs::Search.new(response)

        end

        private

        def api_client
          @api ||= Cb::Utils::Api.new
        end

      end
    end
  end
end
