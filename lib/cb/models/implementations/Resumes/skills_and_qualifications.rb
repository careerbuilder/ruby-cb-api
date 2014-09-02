module Cb
  module Models
    module Resumes
      class SkillsAndQualifications < ApiResponseModel
        attr_accessor :accreditations_and_certifications, :languages_spoken,
                      :has_management_experience, :size_of_team_managed

        def set_model_properties
          args = api_response
          @accreditations_and_certifications = args['accreditationsAndCertifications']
          @languages_spoken = extract_languages_spoken
          @has_management_experience = args['hasManagementExperience']
          @size_of_team_managed = args['sizeOfTeamManaged']
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
