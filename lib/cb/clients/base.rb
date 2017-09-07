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
module Cb
  module Clients
    class Base
      class << self
        def cb_client(headers: {}, use_default_params: true)
          @cb_client ||= Cb::Utils::Api.instance(headers: headers, use_default_params: use_default_params)
        end

        def headers(args, accept_header: 'application/json')
          {
             'Accept' => accept_header,
             'Authorization' => "Bearer #{ args[:oauth_token] }",
             'Content-Type' => 'application/json'
          }
        end
      end
    end
  end
end
