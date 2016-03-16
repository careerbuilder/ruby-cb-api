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
    class Recommendations < ApiResponse
      def validate_api_hash
        check_nonstandard_error_node(response)
        required_response_field(root_node, response)
        required_response_field('results', response[root_node])
      end

      def hash_containing_metadata
        nil
      end

      def extract_models
        response[root_node]['results'].map { |cur_job| Models::RecommendedJob.new(cur_job) }
      end

      def root_node
        'data'
      end

      private

      def check_nonstandard_error_node(api_response)
        fail ApiResponseError.new(api_response['Message']) if api_response.include?('Message')
      end
    end
  end
end
