module Cb
  module Models
    module JobReport
      class Degree < ApiResponseModel
        attr_accessor :degree_name, :number_of_applicants, :percentage_of_applicants

        def set_model_properties
          @degree_name              = api_response['DegreeName']
          @number_of_applicants			= api_response['NumberOfApplicants']
          @state                    = api_response['PercentOfApplicants']
        end

        def required_fields
          ['Degree']
        end

      end
    end
  end
end
