# Copyright 2016 CareerBuilder, LLC
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
require_relative 'base'
module Cb
  module Clients
    class Recommendations < Base
      class << self
        def for_job(*args)
          hash_args = normalize_args(args)
          hash_args = hash_defaults(hash_args)
          json_hash = cb_client.cb_get(Cb.configuration.uri_recommendation_for_job,
                                       query: hash_args)

          {
            jobs: create_jobs(json_hash, 'Job'),
            request: json_hash.dig('ResponseRecommendJob', 'Request'),
            recid: json_hash.dig('ResponseRecommendJob', 'Request', 'RequestEvidenceID'),
            errors: json_hash.dig('ResponseRecommendJob', 'Errors')
          }
        end

        def for_user(*args)
          hash_args = normalize_args(args)
          hash_args = hash_defaults(hash_args)
          json_hash = cb_client.cb_get(Cb.configuration.uri_recommendation_for_user,
                                       query: hash_args)

          {
            jobs: create_jobs(json_hash, 'User'),
            request: json_hash.dig('ResponseRecommendUser', 'Request'),
            recid: json_hash.dig('ResponseRecommendUser', 'Request', 'RequestEvidenceID'),
            errors: json_hash.dig('ResponseRecommendUser', 'Errors')
          }
        end

        private

        def normalize_args(args)
          return args[0] if args[0].class == Hash
          {
            ExternalID: args[0],
            JobDID: args[0],
            CountLimit: args[1] || '25',
            SiteID: args[2] || '',
            CoBrand: args[3] || ''
          }
        end

        def hash_defaults(hash)
          hash[:CountLimit] ||= '25'
          hash[:HostSite] ||= Cb.configuration.host_site
          hash
        end

        def create_jobs(json_hash, type)
          jobs = []

          [json_hash["ResponseRecommend#{type}"]['RecommendJobResults']['RecommendJobResult']].flatten.each do |api_job|
            jobs << Models::Job.new(api_job)
          end

          jobs
        end
      end
    end
  end
end
