module Cb
  module Models
    module Resumes
      class WorkExperience < ApiResponseModel
        attr_accessor :job_title, :company_name, :employment_type, :start_date, :end_date,
                      :currently_employed_here

        def set_model_properties

        end

        def required_fields
          []
        end
      end
    end
  end
end