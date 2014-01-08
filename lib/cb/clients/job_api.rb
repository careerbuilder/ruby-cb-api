require 'json'

module Cb
  class JobApi

    #############################################################
    ## Run a job search against the given criteria
    ##
    ## For detailed information around this API please visit:
    ##
    #############################################################
    def self.search(*args)
      args = args[0] if args.is_a?(Array) && args.count == 1
      my_api = Cb::Utils::Api.new()
      json_hash = my_api.cb_get(Cb.configuration.uri_job_search, :query => args)

      jobs = Array.new
      if !json_hash['ResponseJobSearch'].nil? && !json_hash['ResponseJobSearch']['Results'].nil?
        job_results = json_hash['ResponseJobSearch']['Results']['JobSearchResult']
        job_results = [job_results] if !job_results.is_a?(Array)
        job_results.each { |job_hash| jobs.push(CbJob.new(job_hash)) }
        my_api.append_api_responses(jobs, json_hash['ResponseJobSearch'])

        if response_has_search_metadata?(json_hash['ResponseJobSearch'])
          my_api.append_api_responses(jobs, json_hash['ResponseJobSearch']['SearchMetaData']['SearchLocations']['SearchLocation'])
        end
      end

      my_api.append_api_responses(jobs, json_hash)

      return jobs
    end

    #############################################################
    ## Retrieve a job by did
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/JobInfo.aspx
    #############################################################
    def self.find_by_criteria(criteria)
      my_api = Cb::Utils::Api.new()
      params = my_api.class.criteria_to_hash(criteria)
      json_hash = my_api.cb_get(Cb.configuration.uri_job_find, :query => params)

      if json_hash.has_key?('ResponseJob')
        if json_hash['ResponseJob'].has_key?('Job')
          job = CbJob.new(json_hash['ResponseJob']['Job'])
        end
        my_api.append_api_responses(job, json_hash['ResponseJob'])
      end
      my_api.append_api_responses(job, json_hash)

      return job
    end

    def self.find_by_did(did)
      criteria = Cb::JobDetailsCriteria.new()
      criteria.did = did
      return find_by_criteria(criteria)
    end

    private

    def self.response_has_search_metadata?(response_hash)
      response_hash['SearchMetaData'] &&
      response_hash['SearchMetaData']['SearchLocations'] &&
      response_hash['SearchMetaData']['SearchLocations']['SearchLocation']
    end
  end # JobApi
end # Cb