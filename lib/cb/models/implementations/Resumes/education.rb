module Cb
  module Models
    module Resumes
      class Education < ApiResponseModel
        attr_accessor :school_name, :major_or_program, :degree, :graduation_date

        def set_model_properties
          args = api_response
          @school_name = args['schoolName']
          @major_or_program = args['majorOrProgram']
          @degree = args['degree']
          @graduation_date = args['graduationDate']
        end

        def required_fields
          ['schoolName', 'majorOrProgram']
        end
      end
    end
  end
end
