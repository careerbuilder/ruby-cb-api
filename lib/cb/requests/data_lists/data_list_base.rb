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
  module Requests
    module DataLists
      class DataListBase
        attr_reader :token, :args

        def initialize(token, args)
          @token = token
          @args = args
        end

        def get
          Cb::Responses::ResumeDataList.new request.parsed
        end

        def api_uri
          fail NotImplementedError.new __method__
        end

        private

        def request
          token.get(uri)
        end

        def uri
          base_uri + query_string
        end

        def base_uri
          Cb.configuration.base_uri + api_uri
        end

        def query_string
          args['countrycode'] ? "?countrycode=#{args['countrycode']}" : '?countrycode=US'
        end
      end
    end
  end
end
