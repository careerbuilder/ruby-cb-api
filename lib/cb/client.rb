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
  class Client
    attr_reader :callback_block

    def initialize(&block)
      @callback_block = block
    end

    def execute(request)
      api_response = call_api(request)
      response_class = Cb::Utils::ResponseMap.response_for(request.class)
      response_class.new api_response
    end

    private

    def call_api(request)
      http_wrapper.timed_http_request(
        request.http_method,
        request.base_uri,
        request.endpoint_uri,
        {
          query: request.query,
          headers: request.headers,
          body: request.body
        },
        &@callback_block)
    end

    def http_wrapper
      Cb::Utils::Api.instance
    end
  end
end
