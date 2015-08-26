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
      class Education < ApiResponseModel
        attr_accessor :school_name, :major_or_program, :degree, :graduation_date

        def set_model_properties
          @school_name = api_response['schoolName']
          @major_or_program = api_response['majorOrProgram']
          @degree = api_response['degree']
          @graduation_date = api_response['graduationDate']
        end

        def required_fields
          %w(schoolName majorOrProgram)
        end
      end
    end
  end
end
