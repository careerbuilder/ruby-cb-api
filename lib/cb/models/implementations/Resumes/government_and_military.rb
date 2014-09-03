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
          ['hasSecurityClearance', 'militaryExperience']
        end
      end
    end
  end
end
