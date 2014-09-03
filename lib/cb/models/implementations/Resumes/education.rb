module Cb
  module Models
    module Resumes
      class Education < ApiResponseModel
        attr_accessor :school_name, :major_or_program, :degree, :graduation_date

        def set_model_properties
          @school_name = api_response['schoolName']
          @major_or_program = api_response['majorOrProgram']
          @degree = api_response['degree']
          @graduation_date = api_response['graduationDate']
        end

        def required_fields
          ['schoolName', 'majorOrProgram']
        end
      end
    end
  end
end
