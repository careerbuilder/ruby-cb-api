module Cb
  module Models
    module HireInsider
      class JobInfo < ApiResponseModel
        attr_accessor :company, :days_til_expiration, :degree_required, :experience_required,
                      :job_title, :salary_information

        def set_model_properties
          @company                = HireInsider::Company.new(api_response['Company'])
          @days_til_expiration    = api_response['DaysTilExpire']
          @degree_required        = api_response['DegreeRequired']
          @experience_required    = api_response['ExperienceYearsRequired']
          @job_title              = api_response['JobTitle']
          @salary_information     = extract_salary_information
        end

        def required_fields
          %w(Company DaysTilExpire DegreeRequired ExperienceYearsRequired JobTitle SalaryInformation)
        end

        def extract_salary_information
          HireInsider::Salary.new(api_response['SalaryInformation'])
        end

      end
    end
  end
end
