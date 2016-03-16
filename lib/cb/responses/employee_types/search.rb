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
    module EmployeeTypes
      class Search < ApiResponse
        protected

        def hash_containing_metadata
          response[root_node]
        end

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(outer_collection_node, response[root_node])
          required_response_field(inner_collection_node, employee_types_data)
        end

        def extract_models
          extracted_employee_types_data.map { |emp_type| Models::EmployeeType.new(emp_type) }
        end

        private

        def root_node
          'ResponseEmployeeTypes'
        end

        def outer_collection_node
          'EmployeeTypes'
        end

        def inner_collection_node
          'EmployeeType'
        end

        def employee_types_data
          response[root_node][outer_collection_node]
        end

        def extracted_employee_types_data
          Utils::ResponseArrayExtractor.extract(response[root_node], outer_collection_node)
        end
      end
    end
  end
end
