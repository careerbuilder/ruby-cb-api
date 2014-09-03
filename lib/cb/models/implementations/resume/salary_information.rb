module Cb
  module Models
    module Resumes
      class SalaryInformation < ApiResponseModel
        attr_accessor :most_recent_pay_amount, :per_hour_or_per_year, :currency_code,
                      :job_title, :annual_bonus, :annual_commission

        def set_model_properties
          @most_recent_pay_amount = api_response['mostRecentPayAmount']
          @per_hour_or_per_year = api_response['PerHourOrPerYear']
          @currency_code = api_response['CurrencyCode']
          @job_title = api_response['jobTitle']
          @annual_bonus = api_response['annualBonus']
          @annual_commission = api_response['annualCommission']
        end

        def required_fields
          ['PerHourOrPerYear', 'mostRecentPayAmount']
        end
      end
    end
  end
end
