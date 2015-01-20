module Cb
  module Models
    module Resumes
      class SalaryInformation < ApiResponseModel
        attr_accessor :most_recent_pay_amount, :per_hour_or_per_year, :currency_code,
                      :annual_bonus, :annual_commission, :work_experience_id

        def set_model_properties
          @most_recent_pay_amount = get_api_response 'mostRecentPayAmount'
          @per_hour_or_per_year = get_api_response 'PerHourOrPerYear'
          @currency_code = get_api_response 'CurrencyCode'
          @annual_bonus = get_api_response 'annualBonus'
          @annual_commission = get_api_response 'annualCommission'
          @work_experience_id = get_api_response 'workExperienceId'
        end

        def required_fields
          ['PerHourOrPerYear', 'mostRecentPayAmount']
        end

        private

        def get_api_response(api_key)
          api_response[api_key]
        end

      end
    end
  end
end
