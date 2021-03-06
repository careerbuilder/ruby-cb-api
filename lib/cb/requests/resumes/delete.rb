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
      class Delete < Base
        def endpoint_uri
          Cb.configuration.uri_resume_delete.gsub(':resume_hash', args[:resume_hash].to_s)
        end

        def http_method
          :delete
        end

        def query
          {
            externalUserID: args[:external_user_id]
          }
        end

        def headers
          {
            'DeveloperKey' => Cb.configuration.dev_key,
            'HostSite' => args[:host_site] || Cb.configuration.host_site,
            'Content-Type' => 'application/json;version=1.0'
          }
        end
      end
    end
  end
end
