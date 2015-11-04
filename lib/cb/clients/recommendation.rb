# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'json'

module Cb
  module Clients
    class Recommendation
      def self.for_job(*args)
        my_api = Cb::Utils::Api.instance
        hash = normalize_args(args)
        hash = set_hash_defaults(hash)
        json_hash = my_api.cb_get(Cb.configuration.uri_recommendation_for_job,
                                  query: hash)

        jobs = []

        if json_hash.key?('ResponseRecommendJob')
          if json_hash['ResponseRecommendJob'].key?('RecommendJobResults') &&
             !json_hash['ResponseRecommendJob']['RecommendJobResults'].nil?

            jobs = create_jobs json_hash, 'Job'

            my_api.append_api_responses(jobs, json_hash['ResponseRecommendJob']['Request'])
          end

          my_api.append_api_responses(jobs, json_hash['ResponseRecommendJob'])
        end

        my_api.append_api_responses(jobs, json_hash)
      end

      def self.for_user(*args)
        my_api = Cb::Utils::Api.instance
        hash = normalize_args(args)
        hash = set_hash_defaults(hash)
        json_hash = my_api.cb_get(Cb.configuration.uri_recommendation_for_user,
                                  query: hash)

        jobs = []

        if json_hash.key?('ResponseRecommendUser')

          if json_hash['ResponseRecommendUser'].key?('RecommendJobResults') &&
             !json_hash['ResponseRecommendUser']['RecommendJobResults'].nil?

            jobs = create_jobs json_hash, 'User'

            my_api.append_api_responses(jobs, json_hash['ResponseRecommendUser']['Request'])
          end

          my_api.append_api_responses(jobs, json_hash['ResponseRecommendUser'])
        end

        my_api.append_api_responses(jobs, json_hash)
      end

      def self.for_company(company_did)
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get(Cb.configuration.uri_recommendation_for_company, query: { CompanyDID: company_did })
        jobs = []
        json_hash.fetch('Results', {}).fetch('JobRecommendation', {}).fetch('Jobs', {}).fetch('CompanyJob', []).each do |cur_job|
          jobs << Models::Job.new(cur_job)
        end

        my_api.append_api_responses(jobs, json_hash.fetch('Results', {}).fetch('JobRecommendation', {}))
        my_api.append_api_responses(jobs, json_hash.fetch('Results', {}))
        my_api.append_api_responses(jobs, json_hash)
      end

      private

      def self.normalize_args(args)
        return args[0] if args[0].class == Hash
        {
          ExternalID: args[0],
          JobDID: args[0],
          CountLimit: args[1] || '25',
          SiteID: args[2] || '',
          CoBrand: args[3] || ''
        }
      end

      def self.set_hash_defaults(hash)
        hash[:CountLimit] ||= '25'
        hash[:HostSite] ||= Cb.configuration.host_site
        hash
      end

      def self.create_jobs(json_hash, type)
        jobs = []

        [json_hash["ResponseRecommend#{type}"]['RecommendJobResults']['RecommendJobResult']].flatten.each do |api_job|
          jobs << Models::Job.new(api_job)
        end

        jobs
      end
    end
  end
end
