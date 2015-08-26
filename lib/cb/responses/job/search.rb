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
    module Job
      class Search < ApiResponse
        protected

        def validate_api_hash
          required_response_field(root_node, response)
        end

        def hash_containing_metadata
          response[root_node]
        end

        def extract_models
          if is_collapsed
            Models::CollapsedJobResults.new(response[root_node])
          else
            Models::JobResults.new(response[root_node], job_hashes)
          end
        end

        private

        def root_node
          'ResponseJobSearch'
        end

        def job_hashes
          hashes = response[root_node]['Results']['JobSearchResult'] rescue []

          if hashes.is_a?(Array)
            hashes
          elsif hashes.nil?
            []
          else
            [hashes]
          end
        end

        def is_collapsed
          response[root_node].key?('GroupedJobSearchResults')
        end
      end
    end
  end
end
