module Cb
  module Models
    module Resumes
      class SalaryInformation < ApiResponseModel
        attr_accessor :most_recent_pay_amount, :per_hour_or_per_year, :currency_code,
                      :annual_bonus, :annual_commission, :work_experience_id

        def set_model_properties
          @most_recent_pay_amount = api_response['mostRecentPayAmount']
          @per_hour_or_per_year = api_response['PerHourOrPerYear']
          @currency_code = api_response['CurrencyCode']
          @annual_bonus = api_response['annualBonus']
          @annual_commission = api_response['annualCommission']
          @work_experience_id = api_response['workExperienceId']
        end

        def required_fields
          ['PerHourOrPerYear', 'mostRecentPayAmount']
        end
      end
    end
  end
end
