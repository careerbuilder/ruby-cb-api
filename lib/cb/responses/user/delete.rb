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
  module Responses
    module User
      class Delete < ApiResponse
        class Model < Struct.new(:status); end

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(request_node, response[root_node])
        end

        def extract_models
          model = Model.new
          model.status = response[root_node][status_node]
          model
        end

        def hash_containing_metadata
          response[root_node]
        end

        private

        def root_node
          'ResponseUserDelete'
        end

        def request_node
          'Request'
        end

        def status_node
          'Status'
        end
      end
    end
  end
end
