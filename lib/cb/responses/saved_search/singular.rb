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
    module SavedSearch
      class Singular < ApiResponse
        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(model_node, response[root_node])
        end

        def hash_containing_metadata
          response[root_node]
        end

        def extract_models
          # these IDs comes back in weird places in the response hash,
          # we need to move them around a little bit so things work correctly.
          model_hash[user_id_node] = response[user_id_node]
          model_hash[search_id_node] = response[search_id_node]
          Models::SavedSearch.new(model_hash)
        end

        private

        def root_node
          'SavedJobSearch'
        end

        def model_node
          'SavedSearch'
        end

        def user_id_node
          'ExternalUserID'
        end

        def search_id_node
          'ExternalID'
        end

        def model_hash
          response[root_node][model_node]
        end
      end
    end
  end
end
