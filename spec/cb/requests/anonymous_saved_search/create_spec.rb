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
require 'spec_helper'

module Cb
  describe Cb::Requests::AnonymousSavedSearch::Create do
    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::AnonymousSavedSearch::Create.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_anon_saved_search_create)
          expect(@request.http_method).to eq(:post)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq(nil)
        end

        it 'should have a basic body' do
          expect(@request.body).to eq <<-eos
          <Request>
            <HostSite></HostSite>
            <Cobrand></Cobrand>
            <BrowserID></BrowserID>
            <SessionID></SessionID>
            <Test>false</Test>
            <EmailAddress></EmailAddress>
            <SearchName></SearchName>

            <IsDailyEmail></IsDailyEmail>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
          </Request>
          eos
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::AnonymousSavedSearch::Create.new(host_site: 'host site',
                                                                    test: 'true',
                                                                    cobrand: 'cobrand',
                                                                    browser_id: 'browser id',
                                                                    session_id: 'session id',
                                                                    email_address: 'email@example.com',
                                                                    search_name: 'search name',
                                                                    search_parameters: {
                                                                      boolean_operator: 'boolean operator',
                                                                      job_category: 'job category',
                                                                      education_code: 'education code',
                                                                      emp_type: 'emp type',
                                                                      exclude_company_names: 'exclude company names',
                                                                      exclude_job_titles: 'exclude job titles',
                                                                      exclude_keywords: 'exclude keywords',
                                                                      country: 'country',
                                                                      industry_codes: 'industry codes',
                                                                      job_title: 'job title',
                                                                      keywords: 'jobs',
                                                                      location: 'atlanta',
                                                                      order_by: 'order by',
                                                                      order_direction: 'order direction',
                                                                      pay_high: '100',
                                                                      pay_low: '10',
                                                                      posted_within: '3',
                                                                      radius: '50',
                                                                      specific_education: 'false',
                                                                      exclude_national: 'false',
                                                                      pay_info_only: 'false'
                                                                    },
                                                                    is_daily_email: true)
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_anon_saved_search_create)
          expect(@request.http_method).to eq(:post)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq(nil)
        end

        it 'should have a basic body' do
          expect(@request.body).to eq <<-eos
          <Request>
            <HostSite>host site</HostSite>
            <Cobrand>cobrand</Cobrand>
            <BrowserID>browser id</BrowserID>
            <SessionID>session id</SessionID>
            <Test>true</Test>
            <EmailAddress>email@example.com</EmailAddress>
            <SearchName>search name</SearchName>
            <SearchParameters>
              <BooleanOperator>boolean operator</BooleanOperator>
              <JobCategory>job category</JobCategory>
              <EducationCode>education code</EducationCode>
              <EmpType>emp type</EmpType>
              <ExcludeCompanyNames>exclude company names</ExcludeCompanyNames>
              <ExcludeJobTitles>exclude job titles</ExcludeJobTitles>
              <ExcludeKeywords>exclude keywords</ExcludeKeywords>
              <Country>country</Country>
              <IndustryCodes>industry codes</IndustryCodes>
              <JobTitle>job title</JobTitle>
              <Keywords>jobs</Keywords>
              <Location>atlanta</Location>
              <OrderBy>order by</OrderBy>
              <OrderDirection>order direction</OrderDirection>
              <PayHigh>100</PayHigh>
              <PayLow>10</PayLow>
              <PostedWithin>3</PostedWithin>
              <Radius>50</Radius>
              <SpecificEducation>false</SpecificEducation>
              <ExcludeNational>false</ExcludeNational>
              <PayInfoOnly>false</PayInfoOnly>
            </SearchParameters>

            <IsDailyEmail>true</IsDailyEmail>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
          </Request>
          eos
        end
      end
    end
  end
end
