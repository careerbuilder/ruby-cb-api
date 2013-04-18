require 'json'

module Cb
  class JobApi

    # @@search_criteria = nil
    # @@details_criteria = nil

    # def self.details_criteria
    #   @@details_criteria
    # end
    # def self.details_criteria=(value)
    #   @@details_criteria = value
    # end

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
    def self.find_by_did(did, *criteria)
      # If criteria is a valid DetailsCriteria, use it.  Otherwise, throw it away
      if !criteria.nil? && !criteria.empty? && criteria[0].kind_of?(Cb::JobApi::DetailsCriteria)
        details_criteria = criteria[0]
      end

      my_api = Cb::Utils::Api.new()
      params = Cb::Utils::Api.criteria_to_hash(details_criteria)

      params[:did] = did if params[:did].empty?

      cb_response = my_api.cb_get(Cb.configuration.uri_job_find, :query => params)
      json_hash = JSON.parse(cb_response.response.body)

      job = CbJob.new(json_hash['ResponseJob']['Job'])
      my_api.append_api_responses(job, json_hash['ResponseJob'])

      return job
    end

    class DetailsCriteria
      attr_accessor :did, :show_job_skin, :site_id, :cobrand, :show_apply_requirements

      def find
        Cb.job.find_by_did(Cb::Utils::Api.criteria_to_hash(self)) 
      end 
    end

  end # JobApi
end # Cb