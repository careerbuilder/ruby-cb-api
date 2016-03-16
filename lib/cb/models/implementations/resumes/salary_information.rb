# Copyright 2016 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
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
          %w(PerHourOrPerYear mostRecentPayAmount)
        end

        private

        def get_api_response(api_key)
          api_response[api_key]
        end
      end
    end
  end
end
