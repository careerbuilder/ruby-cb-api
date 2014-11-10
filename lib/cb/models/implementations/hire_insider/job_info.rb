module Cb
  module Models
    module JobReport
      class JobInfo < ApiResponseModel
        attr_accessor :company, :days_til_expiration, :degree_required, :experience_required,
                      :job_title, :salary_information

        def set_model_properties
          @company                = JobReport::Company.new(api_response['Company'])   || String.new
          @days_til_expiration    = api_response['DaysTilExpire']                     || 0.0
          @degree_required        = api_response['DegreeRequired']                    || false
          @experience_required    = api_response['ExperienceYearsRequired']           || 0.0
          @job_title              = api_response['JobTitle']                          || String.new
          @salary_information     = extract_salary_information                        || []
        end

        def extract_salary_information
          unless api_response['SalaryInformation'].nil?
            JobReport::Salary.new(api_response['SalaryInformation'])
          end
        end

        def required_fields
          ['JobInformation']
        end
      end
    end
  end
end
