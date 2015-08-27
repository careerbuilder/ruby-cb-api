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
require 'cb/responses/api_response'

module Cb
  module Responses
    module WorkStatus
      class List < ApiResponse
        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(work_statuses_node, response)
        end

        def extract_models
          [model_array].flatten.map { |work_status| Cb::Models::WorkStatus.new work_status }
        end

        private

        def work_statuses_node
          'WorkStatuses'
        end

        def model_array
          response[work_statuses_node]
        end
      end
    end
  end
end
