require 'json'

module Cb
  module Clients
    class Recommendation

      def self.for_job(did, countlimit = '25', site_id = '', co_brand = '')
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get(Cb.configuration.uri_recommendation_for_job,
                                    :query => {:JobDID => did, :CountLimit => countlimit, :SiteID => site_id,
                                               :CoBrand => co_brand, :HostSite => Cb.configuration.host_site})

        jobs = []
        if json_hash.has_key?('ResponseRecommendJob')
          if json_hash['ResponseRecommendJob'].has_key?('RecommendJobResults') &&
             !json_hash['ResponseRecommendJob']['RecommendJobResults'].nil?

            json_hash['ResponseRecommendJob']['RecommendJobResults']['RecommendJobResult'].each do |cur_job|
              jobs << Models::Job.new(cur_job)
            end

            my_api.append_api_responses(jobs, json_hash['ResponseRecommendJob']['Request'])
          end

          my_api.append_api_responses(jobs, json_hash['ResponseRecommendJob'])
        end

        my_api.append_api_responses(jobs, json_hash)
      end

      def self.for_user(external_id, countlimit = '25', site_id = '', co_brand = '')
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get(Cb.configuration.uri_recommendation_for_user,
                                    :query => {:ExternalID => external_id, :CountLimit => countlimit, :SiteID => site_id, :CoBrand => co_brand,
                                               :HostSite => Cb.configuration.host_site})

        jobs = []
        if json_hash.has_key?('ResponseRecommendUser')

          if json_hash['ResponseRecommendUser'].has_key?('RecommendJobResults') &&
            !json_hash['ResponseRecommendUser']['RecommendJobResults'].nil?

            json_hash['ResponseRecommendUser']['RecommendJobResults']['RecommendJobResult'].each do |cur_job|
              jobs << Models::Job.new(cur_job)
            end
            my_api.append_api_responses(jobs, json_hash['ResponseRecommendUser']['Request'])
          end

          my_api.append_api_responses(jobs, json_hash['ResponseRecommendUser'])
        end

        my_api.append_api_responses(jobs, json_hash)
      end

      def self.for_company(company_did)
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get(Cb.configuration.uri_recommendation_for_company, :query => {:CompanyDID => company_did})

        jobs = []
        if json_hash.has_key?('Results')
          if json_hash['Results'].has_key?('JobRecommendation')
            json_hash['Results']['JobRecommendation']['Jobs'].each do |cur_job|
              jobs << Models::Job.new(cur_job)
            end
            my_api.append_api_responses(jobs, json_hash['Results']['JobRecommendation'])
          end

          my_api.append_api_responses(jobs, json_hash['Results'])
        end

        my_api.append_api_responses(jobs, json_hash)
      end

    end
  end
end
