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
    module Resumes
      class GovernmentAndMilitary < ApiResponseModel
        attr_accessor :has_security_clearance, :military_experience

        def set_model_properties
          @has_security_clearance = api_response['hasSecurityClearance']
          @military_experience = api_response['militaryExperience']
        end

        def required_fields
          %w(hasSecurityClearance militaryExperience)
        end
      end
    end
  end
end
