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
  module Models
    class ResumeDocument < ApiResponseModel
      attr_accessor :resume_id, :desired_job_title, :privacy_setting, :resume_file_data, :resume_file_name, :host_site

      def set_model_properties
        @resume_id = api_response['resumeID']
        @desired_job_title = api_response['desiredJobTitle']
        @privacy_setting = api_response['privacySetting']
        @resume_file_data = api_response['resumeFileData']
        @resume_file_name = api_response['resumeFileName']
        @host_site = api_response['hostSite']
      end

      def required_fields
        ['resumeID']
      end
    end
  end
end
