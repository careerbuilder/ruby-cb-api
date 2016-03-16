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
require_relative '../base'

module Cb
  module Requests
    module Education
      class Get < Base
        def endpoint_uri
          Cb.configuration.uri_education_code
        end

        def http_method
          :get
        end

        def query
          {
            CountryCode: @args[:country_code]
          }
        end
      end
    end
  end
end
