require 'json'

module Cb
  module Clients
    class Job
      class << self

        def search(args)
          response = api_client.cb_get(Cb.configuration.uri_job_search, query: args)
          Cb::Responses::Job::Search.new(response)
        end

        def find_by_criteria(criteria)
        end

        def find_by_did(did)
          criteria = Cb::Criteria::Job::Details.new
          criteria.did = did
          criteria.show_custom_values = true
          find_by_criteria(criteria)
        end

        private

        def api_client
          @api ||= Cb::Utils::Api.new
        end

      end
    end
  end
end
