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
module Cb
  module Clients
    class TalentNetwork
      def self.join_form_questions(tndid)
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get("#{Cb.configuration.uri_tn_join_questions}/#{tndid}/json")
        tn_questions_collection = Models::TalentNetwork.new(json_hash)
        my_api.append_api_responses(tn_questions_collection, json_hash)
      end

      def self.join_form_branding(tndid)
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get("#{Cb.configuration.uri_tn_join_form_branding}/#{tndid}/json")

        if json_hash.key? 'Branding'
          tn_join_form_branding = Models::TalentNetwork::JoinFormBranding.new(json_hash['Branding'])
        end

        my_api.append_api_responses(tn_join_form_branding, json_hash)
      end

      def self.join_form_geography(tnlanguage = 'USEnglish')
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get("#{Cb.configuration.uri_tn_join_form_geo}", query: { TNLanguage: "#{tnlanguage}" })
        geo_dropdown = Models::TalentNetwork::JoinFormGeo.new(json_hash)
        my_api.append_api_responses(geo_dropdown, json_hash)
      end

      def self.member_create(args = {})
        my_api = Cb::Utils::Api.instance
        tn_member = Models::TalentNetwork::Member.new(args)
        json_hash = my_api.cb_post("#{Cb.configuration.uri_tn_member_create}/json", body: tn_member.to_xml)
        my_api.append_api_responses(json_hash, json_hash)
      end

      def self.tn_job_information(job_did, join_form_intercept = 'true')
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get("#{Cb.configuration.uri_tn_job_info}/#{job_did}/json", query: {
                                    RequestJoinFormIntercept: join_form_intercept })

        if json_hash.key? 'Response'
          tn_job_info = Models::TalentNetwork::JobInfo.new(json_hash['Response'])
        end

        my_api.append_api_responses(tn_job_info, json_hash)
      end
    end
  end
end
