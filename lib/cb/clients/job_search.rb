# Copyright 2017 CareerBuilder, LLC
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
    class JobSearch < Base
      class << self
        def get(args = {})
          cb_client.cb_get(Cb.configuration.uri_job_search, query: query(args), headers: headers(args))
        end

        def legacy_get(args = {})
          options = query(args).merge(developerkey: Cb.configuration.dev_key)
          cb_client.cb_get(Cb.configuration.uri_legacy_job_search, query: options)
        end

        private

        def headers(args = {})
          {
             'Accept' => 'application/json;version=3.0',
             'Authorization' => "Bearer #{ args[:oauth_token] }",
             'Content-Type' => 'application/json',
             'HostSite' => args[:host_site] || args[:HostSite] || Cb.configuration.host_site
          }
        end

        def query(args = {})
          args.reject { |k, _| k == :oauth_token }
        end
      end
    end
  end
end
