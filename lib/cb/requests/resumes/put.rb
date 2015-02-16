require_relative '../base'

module Cb
  module Requests
    module Resumes
      class Put < Base
        def endpoint_uri
          Cb.configuration.uri_resume_put.gsub(':resume_hash', args[:resume_hash].to_s)
        end

        def http_method
          :put
        end

        def headers
          {
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json',
            'Authorization' => three_scale_bearer_token
          }
        end

        def body
          {
            userIdentifier: args[:user_identifier],
            resumeHash: args[:resume_hash],
            desiredJobTitle: args[:desired_job_title],
            privacySetting: args[:privacy_setting],
            workExperience: extract_work_experience,
            salaryInformation: extract_salary_information,
            educations: extract_educations,
            skillsAndQualifications: extract_skills_and_qualifications,
            relocations: extract_relocations,
            governmentAndMilitary: extract_government_and_military
          }.to_json
        end

        private

        def extract_work_experience
          return [] if args[:work_experience].blank?
          args[:work_experience].collect do |experience|
            {
              jobTitle: experience[:job_title],
              companyName: experience[:company_name],
              employmentType: experience[:employment_type],
              startDate: experience[:start_date],
              endDate: experience[:end_date],
              currentlyEmployedHere: experience[:currently_employed_here]
            }
          end
        end

        def extract_salary_information
          salary = args[:salary_information]
          return {} if salary.blank?
          {
            mostRecentPayAmount: salary[:most_recent_pay_amount],
            perHourOrPerYear: salary[:per_hour_or_per_year],
            currencyCode: salary[:currency_code],
            jobTitle: salary[:job_title],
            annualBonus: salary[:annual_bonus],
            annualCommission: salary[:annual_commission],
          }
        end

        def extract_educations
          return [] if args[:educations].blank?
          args[:educations].collect do |education|
            {
              schoolName: education[:school_name],
              majorOrProgram: education[:major],
              degreeCode: education[:degree_code],
              graduationDate: education[:graduation_date]
            }
          end
        end

        def extract_skills_and_qualifications
          skills = args[:skills_and_qualifications]
          return {} if skills.blank?
          {
            accreditationsAndCertifications: skills[:accreditations_and_certifications],
            languagesSpoken: skills[:languages_spoken],
            hasManagementExperience: skills[:has_management_experience],
            sizeOfTeamManaged: skills[:size_of_team_managed]
          }
        end


        def extract_relocations
          return [] unless args[:relocations]
          args[:relocations].collect do |relocate|
            {
              city: relocate[:city],
              adminArea: relocate[:admin_area],
              countryCode: relocate[:country_code]
            }
          end
        end

        def extract_government_and_military
          government = args[:government_and_military]
          return {} if government.blank?
          {
            hasSecurityClearance: government[:has_security_clearance],
            militaryExperience: government[:military_experience]
          }
        end

        def three_scale_bearer_token
          "Bearer #{args[:three_scale_token]}"
        end
      end
    end
  end
end

