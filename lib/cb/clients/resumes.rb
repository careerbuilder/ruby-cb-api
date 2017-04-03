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
require_relative 'base'
module Cb
  module Clients
    class Resumes < Base
      class << self
        def get(args = {})
          uri = Cb.configuration.uri_resumes
          query_params = args[:site] ? { site: args[:site] } : {}
          cb_client.cb_get(uri, headers: headers(args), query: query_params)
        end

        def post(args = {})
          cb_client.cb_post(Cb.configuration.uri_resume_post, body: post_body(args), headers: headers(args))
        end

        def delete(args = {})
          cb_client.cb_delete(Cb.configuration.uri_resume_delete.sub(':resume_hash', args[:resume_hash].to_s), query: { externalUserId: args[:external_user_id] }, headers: headers(args))
        end

        def put(args = {})
          cb_client.cb_put(Cb.configuration.uri_resume_put.gsub(':resume_hash', args[:resume_hash].to_s), headers: headers(args), body: put_body(args))
        end

        private

        def post_body(args = {})
          {
            desiredJobTitle: args[:desired_job_title],
            privacySetting: args[:privacy_setting],
            resumeFileData: args[:resume_file_data],
            resumeFileName: args[:resume_file_name],
            hostSite: args[:host_site],
            entryPath: args[:entry_path]
          }.to_json
        end

        def headers(args = {})
          {
            'HostSite' => args[:host_site] || Cb.configuration.host_site,
            'Content-Type' => 'application/json;version=1.0',
            'Authorization' => "Bearer #{ args[:oauth_token] }"
          }
        end

        def put_body(args = {})
          {
            userIdentifier: args[:user_identifier],
            resumeHash: args[:resume_hash],
            desiredJobTitle: args[:desired_job_title],
            privacySetting: args[:privacy_setting],
            workExperience: extract_work_experience(args),
            salaryInformation: extract_salary_information(args),
            educations: extract_educations(args),
            skillsAndQualifications: extract_skills_and_qualifications(args),
            relocations: extract_relocations(args),
            governmentAndMilitary: extract_government_and_military(args)
          }.to_json
        end

        def extract_work_experience(args = {})
          return [] if args[:work_experience].blank?
          args[:work_experience].map do |experience|
            {
              jobTitle: experience[:job_title],
              companyName: experience[:company_name],
              employmentType: experience[:employment_type],
              startDate: experience[:start_date],
              endDate: experience[:end_date],
              currentlyEmployedHere: experience[:currently_employed_here],
              id: experience[:id]
            }
          end
        end

        def extract_salary_information(args = {})
          salary = args[:salary_information]
          return {} if salary.blank?
          {
            mostRecentPayAmount: salary[:most_recent_pay_amount],
            perHourOrPerYear: salary[:per_hour_or_per_year],
            currencyCode: salary[:currency_code],
            workExperienceId: salary[:work_experience_id],
            annualBonus: salary[:annual_bonus],
            annualCommission: salary[:annual_commission]
          }
        end

        def extract_educations(args = {})
          return [] if args[:educations].blank?
          args[:educations].map do |education|
            {
              schoolName: education[:school_name],
              majorOrProgram: education[:major_or_program],
              degree: education[:degree],
              graduationDate: education[:graduation_date]
            }
          end
        end

        def extract_skills_and_qualifications(args = {})
          skills = args[:skills_and_qualifications]
          return {} if skills.blank?
          {
            accreditationsAndCertifications: skills[:accreditations_and_certifications],
            languagesSpoken: skills[:languages_spoken],
            hasManagementExperience: skills[:has_management_experience],
            sizeOfTeamManaged: skills[:size_of_team_managed]
          }
        end

        def extract_relocations(args = {})
          return [] unless args[:relocations]
          args[:relocations].map do |relocate|
            {
              city: relocate[:city],
              adminArea: relocate[:admin_area],
              countryCode: relocate[:country_code]
            }
          end
        end

        def extract_government_and_military(args = {})
          government = args[:government_and_military]
          return {} if government.blank?
          {
            hasSecurityClearance: government[:has_security_clearance],
            militaryExperience: government[:military_experience]
          }
        end
      end
    end
  end
end
