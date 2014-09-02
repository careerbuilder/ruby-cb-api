module Cb
  module Models
    module Resumes
      class GovernmentAndMilitary < ApiResponseModel
        attr_accessor :has_security_clearance, :military_experience

        def set_model_properties
          args = api_response
          @has_security_clearance = args['hasSecurityClearance']
          @military_experience = args['militaryExperience']
        end

        def required_fields
          ['hasSecurityClearance', 'militaryExperience']
        end
      end
    end
  end
end
