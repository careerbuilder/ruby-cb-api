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
      class SkillsAndQualifications < ApiResponseModel
        attr_accessor :accreditations_and_certifications, :languages_spoken,
                      :has_management_experience, :size_of_team_managed

        def set_model_properties
          @accreditations_and_certifications = api_response['accreditationsAndCertifications']
          @languages_spoken = extract_languages_spoken
          @has_management_experience = api_response['hasManagementExperience']
          @size_of_team_managed = api_response['sizeOfTeamManaged']
        end

        def required_fields
          []
        end

        def extract_languages_spoken
          unless api_response['languagesSpoken'].nil?
            api_response['languagesSpoken'].collect do |language|
              language
            end
          end
        end
      end
    end
  end
end
