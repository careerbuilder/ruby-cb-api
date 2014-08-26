module Cb
  module Models
    module Resumes
      class SalaryInformation < ApiResponseModel
        attr_accessor :most_recent_pay_amount, :per_hour_or_per_year, :currency_code,
                      :job_title, :annual_bonus, :annual_commission

        def set_model_properties
          args = api_response
          @most_recent_pay_amount = args['mostRecentPayAmount']
          @per_hour_or_per_year = args['perHourOrPerYear']
          @currency_code = args['currencyCode']
          @job_title = args['jobTitle']
          @annual_bonus = args['annualBonus']
          @annual_commission = args['annualCommission']
        end

        def required_fields
          []
        end
      end
    end
  end
end