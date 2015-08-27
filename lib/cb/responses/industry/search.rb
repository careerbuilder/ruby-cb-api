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
  module Responses
    module Industry
      class Search < ApiResponse
        protected

        def extract_models
          extracted_industries_data.map { |indy| Models::Industry.new(indy) }
        end

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(outer_collection_node, response[root_node])
          required_response_field(inner_collection_node, industry_data)
        end

        def hash_containing_metadata
          response[root_node]
        end

        private

        def root_node
          'ResponseIndustryCodes'
        end

        def outer_collection_node
          'IndustryCodes'
        end

        def inner_collection_node
          'IndustryCode'
        end

        def industry_data
          response[root_node][outer_collection_node]
        end

        def extracted_industries_data
          Utils::ResponseArrayExtractor.extract(response[root_node], outer_collection_node)
        end
      end
    end
  end
end
