require 'json'

module Cb
  class JobApi

    #############################################################
    ## Run a job search against the given criteria
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/JobSearchInfo.aspx
    #############################################################
    def self.search(*args)
        args = args[0] if args.is_a?(Array) && args.count == 1
        my_api = Cb::Utils::Api.new()
        cb_response = my_api.cb_get(Cb.configuration.uri_job_search, :query => args)
        json_hash = JSON.parse(cb_response.response.body)

        jobs = []
        unless json_hash['ResponseJobSearch']['Results'].nil?
          json_hash['ResponseJobSearch']['Results']['JobSearchResult'].each do | cur_job |
            jobs << CbJob.new(cur_job)
          end
        end
        my_api.append_api_responses(jobs, json_hash['ResponseJobSearch'])

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

      cb_response = my_api.cb_get(Cb.configuration.uri_job_find, :query => params)
      json_hash = JSON.parse(cb_response.response.body)

      job = CbJob.new(json_hash['ResponseJob']['Job'])
      my_api.append_api_responses(job, json_hash['ResponseJob'])

      return job
    end

    def self.find_by_did(did)
      criteria = Cb::JobDetailsCriteria.new()
      criteria.did = did
      return find_by_criteria(criteria)
    end
  end # JobApi
  
  class JobDetailsCriteria
    extend Cb::Utils::FluidAttributes

    fluid_attr_accessor :did, :show_job_skin, :site_id, :cobrand, :show_apply_requirements

    def find
      Cb.job.find_by_did(self.did, self) 
    end 
  end

end # Cb