require 'json'

module Cb
  class RecommendationApi
    #############################################################
    ## Get recommendations for a job
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/Recommendations.aspx
    #############################################################
    def self.for_job(did, countlimit = '25', site_id = '', co_brand = '')
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_recommendation_for_job,
                                  :query => {:JobDID => did, :CountLimit => countlimit, :SiteID => site_id,
                                             :CoBrand => co_brand, :HostSite => Cb.configuration.host_site})

      json_hash = JSON.parse(cb_response.response.body)

      jobs = []
      unless json_hash['ResponseRecommendJob']['RecommendJobResults'].nil?
        json_hash['ResponseRecommendJob']['RecommendJobResults']['RecommendJobResult'].each do |cur_job|
          jobs << CbJob.new(cur_job)
        end
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
    def self.for_user(external_id, countlimit = '25', site_id = '', co_brand = '')
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_recommendation_for_user,
                                  :query => {:ExternalID => external_id, :CountLimit => countlimit, :SiteID => site_id, :CoBrand => co_brand,
                                             :HostSite => Cb.configuration.host_site})
      json_hash = JSON.parse(cb_response.response.body)

      jobs = []
      unless json_hash['ResponseRecommendUser']['RecommendJobResults'].nil?
        json_hash['ResponseRecommendUser']['RecommendJobResults']['RecommendJobResult'].each do |cur_job|
          jobs << CbJob.new(cur_job)
        end
      end
      my_api.append_api_responses(jobs, json_hash['ResponseRecommendUser'])
      my_api.append_api_responses(jobs, json_hash['ResponseRecommendUser']['Request'])

      return jobs
    end

    #############################################################
    ## Get recommendations for a company
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/Recommendations.aspx
    #############################################################
    def self.for_company(company_did)
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_recommendation_for_company,
                                  :query => {:CompanyDID => company_did})
      json_hash = JSON.parse(cb_response.response.body)

      jobs = []
      unless json_hash['Results']['JobRecommendation'].nil?
        json_hash['Results']['JobRecommendation']['Jobs'].each do |cur_job|
          jobs << CbJob.new(cur_job)
        end
      end
      my_api.append_api_responses(jobs, json_hash['Results'])
      my_api.append_api_responses(jobs, json_hash['Results']['JobRecommendation'])

      return jobs
    end
  end
end
