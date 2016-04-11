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
require_relative 'base'
module Cb
  module Clients
    class DataList < Base
      class << self
        # https://careerbuilder.readme.io/docs/consumerdatalistcountries
        def get(args={})
          uri = "#{ Cb.configuration.uri_data_list }/#{ args[:list] }"
          cb_client.cb_get(uri, headers: headers(args), query: query_strings(args))
        end

        private
        
        def query_strings(args)
          qs = {}
          qs[:countrycode] = args[:country_code] if args[:country_code]
          qs
        end
      end
    end
  end
end
