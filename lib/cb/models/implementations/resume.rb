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
    class Resume < ApiResponseModel
      attr_accessor :desired_job_title, :user_identifier, :resume_hash, :privacy_setting, :work_experience, :salary_information,
                    :educations, :skills_and_qualifications, :relocations, :government_and_military

      def set_model_properties
        @desired_job_title = api_response['desiredJobTitle']
        @user_identifier = api_response['userIdentifier']
        @resume_hash = api_response['resumeHash']
        @privacy_setting = api_response['privacySetting']
        @work_experience = extract_work_experience
        @salary_information = extract_salary_information
        @educations = extract_educations
        @skills_and_qualifications = extract_skills_and_qualifications
        @relocations = extract_relocations
        @government_and_military = extract_government_and_military
      end

      def required_fields
        ['userIdentifier']
      end

      private

      def extract_work_experience
        unless api_response['workExperience'].nil?
          api_response['workExperience'].collect do |experience|
            Resumes::WorkExperience.new(experience)
          end
        end
      end

      def extract_salary_information
        unless api_response['salaryInformation'].nil?
          Resumes::SalaryInformation.new(api_response['salaryInformation'])
        end
      end

      def extract_educations
        unless api_response['educations'].nil?
          api_response['educations'].collect do |education|
            Resumes::Education.new(education)
          end
        end
      end

      def extract_skills_and_qualifications
        unless api_response['skillsAndQualifications'].nil?
          Resumes::SkillsAndQualifications.new(api_response['skillsAndQualifications'])
        end
      end

      def extract_relocations
        unless api_response['relocations'].nil?
          api_response['relocations'].collect do |relocation|
            Resumes::Relocation.new(relocation)
          end
        end
      end

      def extract_government_and_military
        unless api_response['governmentAndMilitary'].nil?
          Resumes::GovernmentAndMilitary.new(api_response['governmentAndMilitary'])
        end
      end
    end
  end
end
