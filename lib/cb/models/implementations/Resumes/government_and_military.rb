module Cb
  module Models
    module Resumes
      class GovernmentAndMilitary < ApiResponseModel
        attr_accessor :security_clearance, :military_experience

        def set_model_properties
          args = api_response
          @security_clearance = args['securityClearance']
          @military_experience = args['militaryExperience']
        end

        def required_fields
          ['securityClearance', 'militaryExperience']
        end
      end
    end
  end
end