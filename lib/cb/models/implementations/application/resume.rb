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
  module Models
    class Application < ApiResponseModel
      class Resume < ApiResponseModel
        attr_accessor :external_resume_id, :resume_file_name, :resume_data, :resume_extension, :resume_title

        protected

        def required_fields
          %w(ExternalResumeID)
        end

        def set_model_properties
          @external_resume_id = api_response['ExternalResumeID']
          @resume_file_name = api_response['ResumeFileName']
          @resume_data = api_response['ResumeData']
          @resume_extension = api_response['ResumeExtension']
          @resume_title = api_response['ResumeTitle']
        end
      end
    end
  end
end
