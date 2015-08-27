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
    class ApplicationForm < ApiResponse
      protected

      def hash_containing_metadata
        response
      end

      def validate_api_hash
        required_response_field('Results', response)
      end

      def extract_models
        response['Results'].map { |app_form_data| Cb::Models::Application::Form.new(app_form_data) }
      end
    end
  end
end
