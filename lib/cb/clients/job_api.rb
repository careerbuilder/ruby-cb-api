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
    def self.find_by_did(did, params = {})
      my_api = Cb::Utils::Api.new()
      params[:did] = did
      if params["showjobskin"].nil?
        params["showjobskin"] = "Full"
      end
      cb_response = my_api.cb_get(Cb.configuration.uri_job_find, :query => params)
      json_hash = JSON.parse(cb_response.response.body)

      job = CbJob.new(json_hash['ResponseJob']['Job'])
      my_api.append_api_responses(job, json_hash['ResponseJob'])

      return job
    end
  end # JobApi
end # Cb