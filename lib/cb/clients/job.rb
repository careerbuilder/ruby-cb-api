require 'json'

module Cb
  module Clients
    class Job

      def self.search(api_args_hash)
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get(Cb.configuration.uri_job_search, :query => api_args_hash)

        jobs = Array.new
        if !json_hash['ResponseJobSearch'].nil? && !json_hash['ResponseJobSearch']['Results'].nil?
          job_results = json_hash['ResponseJobSearch']['Results']['JobSearchResult']
          job_results = [job_results] unless job_results.is_a?(Array)
          job_results.each { |job_hash| jobs.push(Models::Job.new(job_hash)) }
          my_api.append_api_responses(jobs, json_hash['ResponseJobSearch'])

          if response_has_search_metadata?(json_hash['ResponseJobSearch'])
            my_api.append_api_responses(jobs, json_hash['ResponseJobSearch']['SearchMetaData']['SearchLocations']['SearchLocation'])
          end
        end

        my_api.append_api_responses(jobs, json_hash)
      end

      def self.find_by_criteria(criteria)
        my_api = Cb::Utils::Api.new
        params = my_api.class.criteria_to_hash(criteria)
        json_hash = my_api.cb_get(Cb.configuration.uri_job_find, :query => params)

        if json_hash.has_key?('ResponseJob')
          if json_hash['ResponseJob'].has_key?('Job')
            job = Models::Job.new(json_hash['ResponseJob']['Job'])
          end
          my_api.append_api_responses(job, json_hash['ResponseJob'])
        end
        my_api.append_api_responses(job, json_hash)
      end

      def find_by_criteria(criteria)
        my_api = Cb::Utils::Api.new
        query = my_api.class.criteria_to_hash(criteria)
        json_response = cb_client.cb_get(Cb.configuration.uri_job_find, :query => query)
        singular_model_response(json_response, criteria.did)
      end

      def self.find_by_did(did)
        criteria = Cb::Criteria::Job::Details.new
        criteria.did = did
        criteria.show_custom_values = true
        return find_by_criteria(criteria)
      end

      private

      def self.response_has_search_metadata?(response_hash)
        response_hash['SearchMetaData'] &&
        response_hash['SearchMetaData']['SearchLocations'] &&
        response_hash['SearchMetaData']['SearchLocations']['SearchLocation']
      end

      def cb_client
        @cb_client ||= Cb.api_client.new
      end

      def singular_model_response(json_hash, did = nil)
        json_hash['DID'] = did unless did = nil?
        Responses::Job::Singular.new(json_hash)
      end

    end
  end
end
