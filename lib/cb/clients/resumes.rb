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
require_relative 'base'
module Cb
  module Clients
    class Resumes < Base
      class << self
        def get(args = {})
          uri = Cb.configuration.uri_resumes
          query_params = args[:site] ? { site: args[:site] } : {}
          cb_client.cb_get(uri, headers: headers(args), query: query_params)
        end

        def post(args = {})
          cb_client.cb_post(Cb.configuration.uri_resume_post, body: post_body(args), headers: headers(args))
        end

        def delete(args = {})
          cb_client.cb_delete(Cb.configuration.uri_resume_delete.sub(':resume_hash', args[:resume_hash].to_s), query: { externalUserId: args[:external_user_id] }, headers: headers(args))
        end

        private

        def post_body(args = {})
          {
            desiredJobTitle: args[:desired_job_title],
            privacySetting: args[:privacy_setting],
            resumeFileData: args[:resume_file_data],
            resumeFileName: args[:resume_file_name],
            hostSite: args[:host_site],
            entryPath: args[:entry_path]
          }.to_json
        end

        def headers(args = {})
          {
            'HostSite' => args[:host_site] || Cb.configuration.host_site,
            'Content-Type' => 'application/json;version=1.0',
            'Authorization' => "Bearer #{ args[:oauth_token] }"
          }
        end
      end
    end
  end
end
