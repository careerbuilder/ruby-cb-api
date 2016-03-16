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
    class ResumeDocument < ApiResponse
      attr_accessor :resume_id, :desired_job_title, :privacy_setting, :resume_file_data, :resume_file_name, :host_site

      def validate_api_hash
        required_response_field(root_node, response)
      end

      def extract_models
        response[root_node].map { |resume| Models::ResumeDocument.new(resume) }
      end

      def hash_containing_metadata
        response
      end

      def root_node
        'Results'
      end
    end
  end
end
