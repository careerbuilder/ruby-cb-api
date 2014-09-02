module Cb
  module Models
    module Resumes
      class WorkExperience < ApiResponseModel
        attr_accessor :job_title, :company_name, :employment_type, :start_date, :end_date,
                      :currently_employed_here

        def set_model_properties
          args = api_response
          @job_title = args['jobTitle']
          @company_name = args['companyName']
          @employment_type = args['employmentType']
          @start_date = args['startDate']
          @end_date = args['endDate']
          @currently_employed_here = args['currentlyEmployedHere']
        end

        def required_fields
          ['jobTitle', 'currentlyEmployedHere']
        end
      end
    end
  end
end
