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
    class JobBranding
      def self.find_by_id(id)
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get Cb.configuration.uri_job_branding, query: { id: id }

        if json_hash.key? 'Branding'
          branding = Models::JobBranding.new json_hash['Branding']
          my_api.append_api_responses(branding, json_hash['Branding'])
        end

        my_api.append_api_responses(branding, json_hash)
      end
    end
  end
end
