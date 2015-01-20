module Cb
  module Models
    module Resumes
      class WorkExperience < ApiResponseModel
        attr_accessor :job_title, :company_name, :employment_type, :start_date, :end_date,
                      :currently_employed_here, :id

        def set_model_properties
          @job_title = api_response['jobTitle']
          @company_name = api_response['companyName']
          @employment_type = api_response['employmentType']
          @start_date = api_response['startDate']
          @end_date = api_response['endDate']
          @currently_employed_here = api_response['currentlyEmployedHere']
          @id = api_response['id']
        end

        def required_fields
          ['jobTitle', 'currentlyEmployedHere']
        end
      end
    end
  end
end
