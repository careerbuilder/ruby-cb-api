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
    module AnonymousSavedSearch
      class Create < ApiResponse
        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(external_id_node, response)
          required_response_field(model_node, response)
        end

        def extract_models
          # external ID comes back outside of the model node so we need to do some rearranging
          response[model_node][external_id_node] = response[external_id_node]
          Models::SavedSearch.new(response[model_node])
        end

        private

        def model_node
          'AnonymousSavedSearch'
        end

        def external_id_node
          'ExternalID'
        end
      end
    end
  end
end
