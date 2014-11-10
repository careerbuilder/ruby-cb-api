module Cb
  module Models
    module JobReport
      class Location < ApiResponseModel
        attr_accessor :number_of_applicants, :state

        def set_model_properties
          @number_of_applicants			= api_response['NumberOfApplicants']
          @state                    = api_response['State']
        end

        def required_fields
          ['Location']
        end
      end
    end
  end
end
