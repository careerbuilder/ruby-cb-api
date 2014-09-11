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
            'DeveloperKey' => Cb.configuration.dev_key,
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json'
          }
        end

        def body
          {
            userIdentifier: args[:user_identifier],
            resumeHash: args[:resume_hash],
            desiredJobTitle: args[:desired_job_title],
            privacySetting: args[:privacy_setting],
            workExperience: args[:salary_information].nil? ? something : salary_information(args[:salary_information]),
            workExperience: work_experience,
            salaryInformation: salary_information(args[:salary_information]),
            educations: educations,
            skillsAndQualifications: skills_and_qualifications(args[:skills_and_qualifications]),
            relocations: relocations,
            governmentAndMilitary: government_and_military(args[:government_and_military])
          }.to_json
        end

        def work_experience
          unless args[:work_experience].nil?
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
        end

        def salary_information(salary)
          {
          mostRecentPayAmount: salary[:most_recent_pay_amount],
          PerHourOrPerYear: salary[:per_hour_or_per_year],
          CurrencyCode: salary[:currency_code],
          jobTitle: salary[:job_title],
          annualBonus: salary[:annual_bonus],
          annualCommission: salary[:annual_commission],
          }
        end

        def educations
          unless args[:educations].nil?
            args[:educations].collect do |education|
              {
              SchoolName: education[:school_name],
              Major: education[:major],
              DegreeCode: education[:degree_code],
              GraduationDate: education[:graduation_date]
              }
            end
          end
        end

        def skills_and_qualifications(skills)
          {
          accreditationsAndCertifications: skills[:accreditations_and_certifications],
          languagesSpoken: languages_spoken(skills[:languages_spoken]),
          hasManagementExperience: skills[:has_management_experience],
          sizeOfTeamManaged: skills[:size_of_team_managed]
          }
        end

        def languages_spoken(languages)
          languages.collect do |languages_spoken|
            languages_spoken
          end
        end

        def relocations
          unless args[:relocations].nil?
            args[:relocations].collect do |relocate|
              {
              city: relocate[:city],
              adminArea: relocate[:admin_area],
              countryCode: relocate[:country_code]
              }
            end
          end
        end

        def government_and_military(government)
            {
            hasSecurityClearance: government[:has_security_clearance],
            militaryExperience: government[:military_experience]
            }
        end
      end
    end
  end
end
