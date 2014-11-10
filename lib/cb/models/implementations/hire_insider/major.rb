module Cb
  module Models
    module JobReport
      class Major < ApiResponseModel
        attr_accessor :major_name, :number_of_applicants, :percentage_of_applicants

        def set_model_properties
          @major_name               = api_response['MajorName']
          @number_of_applicants			= api_response['NumberOfApplicants']
          @state                    = api_response['PercentOfApplicants']
        end

        def required_fields
          ['Major']
        end

      end
    end
  end
end
