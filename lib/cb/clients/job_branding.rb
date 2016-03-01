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
    class JobBranding < Base
      def self.find_by_id(id)
        json_hash = cb_client.cb_get Cb.configuration.uri_job_branding, query: { id: id }

        if json_hash.key? 'Branding'
          branding = Models::JobBranding.new json_hash['Branding']
          cb_client.append_api_responses(branding, json_hash['Branding'])
        end

        cb_client.append_api_responses(branding, json_hash)
      end
    end
  end
end
