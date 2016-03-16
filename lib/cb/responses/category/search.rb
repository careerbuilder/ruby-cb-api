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
require 'cb/responses/api_response'

module Cb
  module Responses
    module Category
      class Search < ApiResponse
        protected

        def hash_containing_metadata
          response
        end

        def validate_api_hash
          required_response_field(response_node, response)
          required_response_field(categories_node, response[response_node])
          required_response_field(category_node, response[response_node][categories_node])
        end

        def extract_models
          model_array.map { |category| Cb::Models::Category.new(category) }
        end

        private

        def response_node
          'ResponseCategories'
        end

        def categories_node
          'Categories'
        end

        def category_node
          'Category'
        end

        def model_array
          response[response_node][categories_node][category_node]
        end
      end
    end
  end
end
