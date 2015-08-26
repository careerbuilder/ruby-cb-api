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
    class LanguageCodes < ApiResponse
      protected

      def validate_api_hash
        required_response_field(root_node, response)
        required_response_field(collection_node, response[root_node])
        required_response_field('LanguageCode', response[root_node][collection_node])
      end

      def hash_containing_metadata
        response[root_node]
      end

      def extract_models
        model_hash.map { |language_code| Models::LanguageCode.new(language_code) }
      end

      private

      def root_node
        'ResponseLanguageCodes'
      end

      def collection_node
        'LanguageCodes'
      end

      def model_hash
        response[root_node][collection_node]['LanguageCode']
      end
    end
  end
end
