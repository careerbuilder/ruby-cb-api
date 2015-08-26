# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require_relative '../base'

module Cb
  module Requests
    module AnonymousSavedSearch
      class Create < Base
        def endpoint_uri
          Cb.configuration.uri_anon_saved_search_create
        end

        def http_method
          :post
        end

        def body
          <<-eos
          <Request>
            <HostSite>#{args[:host_site]}</HostSite>
            <Cobrand>#{args[:cobrand]}</Cobrand>
            <BrowserID>#{args[:browser_id]}</BrowserID>
            <SessionID>#{args[:session_id]}</SessionID>
            <Test>#{test?}</Test>
            <EmailAddress>#{args[:email_address]}</EmailAddress>
            <SearchName>#{args[:search_name]}</SearchName>
#{search_parameters(args[:search_parameters]) unless args[:search_parameters].nil?}
            <IsDailyEmail>#{args[:is_daily_email]}</IsDailyEmail>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
          </Request>
          eos
        end

        private

        def search_parameters(args)
          <<-eos
            <SearchParameters>
              <BooleanOperator>#{args[:boolean_operator]}</BooleanOperator>
              <JobCategory>#{args[:job_category]}</JobCategory>
              <EducationCode>#{args[:education_code]}</EducationCode>
              <EmpType>#{args[:emp_type]}</EmpType>
              <ExcludeCompanyNames>#{args[:exclude_company_names]}</ExcludeCompanyNames>
              <ExcludeJobTitles>#{args[:exclude_job_titles]}</ExcludeJobTitles>
              <ExcludeKeywords>#{args[:exclude_keywords]}</ExcludeKeywords>
              <Country>#{args[:country]}</Country>
              <IndustryCodes>#{args[:industry_codes]}</IndustryCodes>
              <JobTitle>#{args[:job_title]}</JobTitle>
              <Keywords>#{args[:keywords]}</Keywords>
              <Location>#{args[:location]}</Location>
              <OrderBy>#{args[:order_by]}</OrderBy>
              <OrderDirection>#{args[:order_direction]}</OrderDirection>
              <PayHigh>#{args[:pay_high]}</PayHigh>
              <PayLow>#{args[:pay_low]}</PayLow>
              <PostedWithin>#{args[:posted_within]}</PostedWithin>
              <Radius>#{args[:radius]}</Radius>
              <SpecificEducation>#{args[:specific_education]}</SpecificEducation>
              <ExcludeNational>#{args[:exclude_national]}</ExcludeNational>
              <PayInfoOnly>#{args[:pay_info_only]}</PayInfoOnly>
            </SearchParameters>
eos
        end
      end
    end
  end
end
