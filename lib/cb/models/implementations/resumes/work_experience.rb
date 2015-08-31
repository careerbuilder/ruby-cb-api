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
    module Resumes
      class WorkExperience < ApiResponseModel
        attr_accessor :job_title, :company_name, :employment_type, :start_date, :end_date,
                      :currently_employed_here, :id

        def set_model_properties
          @job_title = api_response['jobTitle']
          @company_name = api_response['companyName']
          @employment_type = api_response['employmentType']
          @start_date = api_response['startDate']
          @end_date = api_response['endDate']
          @currently_employed_here = api_response['currentlyEmployedHere']
          @id = api_response['id']
        end

        def required_fields
          %w(jobTitle currentlyEmployedHere)
        end
      end
    end
  end
end
