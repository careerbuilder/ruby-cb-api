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
module  Cb
  module Requests
    module JobSearch
      class Get < Base
        attr_reader :token
        
        def initialize(argument_hash, token)
          super(argument_hash)
          @token = token
        end
        
        def endpoint_uri
          Cb.configuration.uri_job_search_v3
        end

        def http_method
          :get
        end

        def headers
          {
            'HostSite' => args[:host_site] || Cb.configuration.host_site,
            'Accept' => 'applicatin/json;version=3.0'
          }.merge(token.headers)
        end
        
        def query
          args
        end
        
      end
    end
  end
end
