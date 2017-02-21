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
require_relative '../base'

module Cb
  module Requests
    module Resumes
      class Post < Base
        def endpoint_uri
          Cb.configuration.uri_resume_post
        end

        def http_method
          :post
        end

        def body
          {
            desiredJobTitle: args[:desired_job_title],
            privacySetting: args[:privacy_setting],
            resumeFileData: args[:resume_file_data],
            resumeFileName: args[:resume_file_name],
            hostSite: args[:host_site],
            entryPath: args[:entry_path]
          }.to_json
        end

        def headers
          {
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json;version=1.0',
            'Authorization' => three_scale_bearer_token
          }
        end

        def three_scale_bearer_token
          "Bearer #{args[:three_scale_token]}"
        end
      end
    end
  end
end
