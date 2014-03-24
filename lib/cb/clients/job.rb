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
          query = api_client.class.criteria_to_hash(criteria)
          json_response = api_client.cb_get(Cb.configuration.uri_job_find, query: query)
          Responses::Job::Singular.new(json_response)
        end

        def find_by_did(did)
          criteria = Cb::Criteria::Job::Details.new
          criteria.did = did
          criteria.show_custom_values = true
          find_by_criteria(criteria)
        end

        private

        def api_client
          @api ||= Cb::Utils::Api.instance
        end

      end
    end
  end
end
