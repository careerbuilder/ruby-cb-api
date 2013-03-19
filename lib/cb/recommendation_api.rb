require 'json'

module Cb
  class RecommendationApi
    #############################################################
    ## Get recommendations for a job
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/Recommendations.aspx
    #############################################################
    def self.for_job(did, site_id = '', co_brand = '')
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_recommendation_for_job,
                                  :query => {:JobDID => did, :SiteID => site_id, :CoBrand => co_brand})
      json_hash = JSON.parse(cb_response.response.body)

      jobs = []
      json_hash['ResponseRecommendJob']['RecommendJobResults']['RecommendJobResult'].each do |cur_job|
        jobs << CbJob.new(cur_job)
      end
      my_api.append_api_responses(jobs, json_hash['ResponseRecommendJob'])
      my_api.append_api_responses(jobs, json_hash['ResponseRecommendJob']['Request'])

      return jobs
    end

    #############################################################
    ## Get recommendations for a user
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/Recommendations.aspx
    #############################################################
    def self.for_user(external_id, site_id = '', co_brand = '')
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_recommendation_for_job,
                                  :query => {:ExternalID => external_id, :SiteID => site_id, :CoBrand => co_brand,
                                  :HostSite => Cb.configuration.host_site})
      json_hash = JSON.parse(cb_response.response.body)

      jobs = []
      json_hash['ResponseRecommendUser']['RecommendJobResults']['RecommendJobResult'].each do |cur_job|
        jobs << CbJob.new(cur_job)
      end
      my_api.append_api_responses(jobs, json_hash['ResponseRecommendUser'])
      my_api.append_api_responses(jobs, json_hash['ResponseRecommendUser']['Request'])

      return jobs
    end
  end
end
