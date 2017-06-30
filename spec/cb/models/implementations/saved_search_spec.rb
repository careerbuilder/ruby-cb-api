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
require 'spec_helper'

module Cb
  module Models
    describe SavedSearch do
      let(:saved_search) { Models::SavedSearch.new }
      let(:search_parameters) { Models::SavedSearch::SearchParameters.new }

      context '.new' do
        it 'should create a new saved job search object' do
          external_user_id = 'XRHS3LN6G55WX61GXJG8'
          host_site = 'WR'
          search_name = 'Fake Job Search 2'
          did = 'the id of the thing'
          is_daily_email = false

          user_saved_search = Cb::Models::SavedSearch.new('IsDailyEmail' => is_daily_email,
                                                          'ExternalUserID' => external_user_id, 'SearchName' => search_name,
                                                          'DID' => did,
                                                          'HostSite' => host_site,
                                                          'SearchParameters' => mock_search_parameters_response)

          expect(user_saved_search).to be_a_kind_of(Cb::Models::SavedSearch)
          expect(user_saved_search.is_daily_email).to eq(is_daily_email)
          expect(user_saved_search.host_site).to eq(host_site)
          expect(user_saved_search.search_name).to eq(search_name)
          expect(user_saved_search.external_user_id).to eq(external_user_id)
          expect(user_saved_search.did).to eq(did)
          expect(user_saved_search.search_parameters).to be_a Cb::Models::SavedSearch::SearchParameters
        end

        it 'should create a search parameter ' do
          saved_search_parameters = Cb::Models::SavedSearch::SearchParameters.new(mock_search_parameters_response)

          expect(saved_search_parameters.boolean_operator).to eq('BooleanOperator')
          expect(saved_search_parameters.category).to eq('Category')
          expect(saved_search_parameters.city).to eq('City')
          expect(saved_search_parameters.company).to eq('Company')
          expect(saved_search_parameters.country).to eq('Country')
          expect(saved_search_parameters.education_code).to eq('EducationCode')
          expect(saved_search_parameters.emp_type).to eq('EmpType')
          expect(saved_search_parameters.exclude_company_names).to eq('ExcludeCompanyNames')
          expect(saved_search_parameters.exclude_job_titles).to eq('ExcludeJobTitles')
          expect(saved_search_parameters.exclude_keywords).to eq('ExcludeKeywords')
          expect(saved_search_parameters.exclude_national).to eq('ExcludeNational')
          expect(saved_search_parameters.industry_codes).to eq('IndustryCodes')
          expect(saved_search_parameters.jc_advertiser_flags).to eq('JCAdvertiserFlags')
          expect(saved_search_parameters.jc_job_nature).to eq('JCJobNature')
          expect(saved_search_parameters.jc_location).to eq('JCLocation')
          expect(saved_search_parameters.jc_position_level).to eq('JCPositionLevel')
          expect(saved_search_parameters.job_category).to eq('')
          expect(saved_search_parameters.job_title).to eq('JobTitle')
          expect(saved_search_parameters.keywords).to eq('Keywords')
          expect(saved_search_parameters.location).to eq('Location')
          expect(saved_search_parameters.order_by).to eq('OrderBy')
          expect(saved_search_parameters.order_direction).to eq('OrderDirection')
          expect(saved_search_parameters.pay_high).to eq('PayHigh')
          expect(saved_search_parameters.pay_info_only).to eq('PayInfoOnly')
          expect(saved_search_parameters.pay_low).to eq('PayLow')
          expect(saved_search_parameters.posted_within).to eq('PostedWithin')
          expect(saved_search_parameters.radius).to eq('Radius')
          expect(saved_search_parameters.specific_education).to eq('SpecificEducation')
          expect(saved_search_parameters.state).to eq('State')
        end
      end

      describe '#delete_anon_to_xml' do
        before do
          saved_search.external_id = 'BigMoom'
          Cb.configuration.dev_key = 'who dat'
        end
        it 'serialized correctly' do
          xml = saved_search.delete_anon_to_xml
          expect(xml).to eq <<-eos
          <Request>
            <ExternalID>BigMoom</ExternalID>
            <DeveloperKey>who dat</DeveloperKey>
            <Test>false</Test>
          </Request>
          eos
        end
      end

      # describe '#create_to_xml' do
        # before do
          # saved_search.host_site = 'US'
          # saved_search.cobrand = 'AOLer'
          # saved_search.search_name = 'Yolo'
          # add_search_params
          # saved_search.search_parameters = search_parameters
          # saved_search.is_daily_email = true
          # saved_search.external_user_id = 'BigMoomGuy'
          # Cb.configuration.dev_key = 'who dat'
        # end
        # it 'serialized correctly' do
          # xml = saved_search.create_to_xml
          # expect(xml).to eq <<-eos
          # <Request>
            # <HostSite>US</HostSite>
            # <Cobrand>AOLer</Cobrand>
            # <SearchName>Yolo</SearchName>
            # #{search_parameters.to_xml}
            # <IsDailyEmail>TRUE</IsDailyEmail>
            # <ExternalUserID>BigMoomGuy</ExternalUserID>
            # <DeveloperKey>who dat</DeveloperKey>
          # </Request>
          # eos
        # end
      # end

      describe '#create_to_json' do
        before do
          saved_search.host_site = 'US'
          saved_search.cobrand = 'AOLer'
          saved_search.search_name = 'Yolo'
          add_search_params
          saved_search.search_parameters = search_parameters
          saved_search.is_daily_email = false
          saved_search.email_delivery_day = 'NONE'
          saved_search.user_oauth_token = 'My token, mmhmmm yes'
          Cb.configuration.dev_key = 'who dat'
        end
        it 'serialized correctly' do
          json = saved_search.create_to_json
          expect(json).to eq ({
            'SiteID' => '',
            'Cobrand' => 'AOLer',
            'EmailDeliveryDay' => 'NONE',
            'IsDailyEmail' => "FALSE",
            'userOAuthToken' => 'My token, mmhmmm yes',
            'HostSite' => 'US',
            'SearchName' => 'Yolo',
            'SavedSearchParameters' => search_parameters.to_hash
          }.to_json)
        end
      end
      
      describe '#create_anon_to_xml' do
        before do
          saved_search.host_site = 'US'
          saved_search.cobrand = 'AOLer'
          saved_search.browser_id = 'my_bid'
          saved_search.session_id = 'my_sid'
          saved_search.email_address = 'k@cb.moom'
          saved_search.search_name = 'Yolo'
          add_search_params
          saved_search.search_parameters = search_parameters
          saved_search.is_daily_email = true
          Cb.configuration.dev_key = 'who dat'
        end
        it 'serialized correctly' do
          xml = saved_search.create_anon_to_xml
          expect(xml).to eq <<-eos
          <Request>
            <HostSite>US</HostSite>
            <Cobrand>AOLer</Cobrand>
            <BrowserID>my_bid</BrowserID>
            <SessionID>my_sid</SessionID>
            <Test>false</Test>
            <EmailAddress>k@cb.moom</EmailAddress>
            <SearchName>Yolo</SearchName>
            #{search_parameters.to_xml}
            <IsDailyEmail>TRUE</IsDailyEmail>
            <DeveloperKey>who dat</DeveloperKey>
          </Request>
          eos
        end
      end

      describe '#update_to_json' do
        before do
          saved_search.host_site = 'US'
          saved_search.cobrand = 'AOLer'
          saved_search.search_name = 'Yolo'
          add_search_params
          saved_search.search_parameters = search_parameters
          saved_search.is_daily_email = true
          saved_search.email_delivery_day = 'FRIDAY, GET DOWN ON IT'
          saved_search.did = 'Mooma did'
          saved_search.user_oauth_token = 'My token, mmhmmm yes'
          Cb.configuration.dev_key = 'who dat'
        end
        it 'serialized correctly with daily email true' do
          json = saved_search.update_to_json
          expect(json).to eq ({
            'DID' => 'Mooma did',
            'SearchName' => 'Yolo',
            'HostSite' => 'US',
            'SiteID' => '',
            'Cobrand' => 'AOLer',
            'EmailDeliveryDay' => 'FRIDAY, GET DOWN ON IT',
            'IsDailyEmail' => true,
            'userOAuthToken' => 'My token, mmhmmm yes',
            'SavedSearchParameters' => search_parameters.to_hash
          }.to_json)
        end
        it 'serialized correctly with daily email false' do
          saved_search.is_daily_email = false
          json = saved_search.update_to_json
          expect(json).to eq ({
            'DID' => 'Mooma did',
            'SearchName' => 'Yolo',
            'HostSite' => 'US',
            'SiteID' => '',
            'Cobrand' => 'AOLer',
            'EmailDeliveryDay' => 'FRIDAY, GET DOWN ON IT',
            'IsDailyEmail' => false,
            'userOAuthToken' => 'My token, mmhmmm yes',
            'SavedSearchParameters' => search_parameters.to_hash
          }.to_json)
        end
      end

      describe SavedSearch::SearchParameters do
        describe '#to_xml' do
          before { add_search_params }
          it 'serialized correctly' do
            expect(search_parameters.to_xml).to eq <<-eos
            <SearchParameters>
              <BooleanOperator>AND</BooleanOperator>
              <JobCategory>medical</JobCategory>
              <EducationCode>EDU#1</EducationCode>
              <EmpType>FullTime</EmpType>
              <ExcludeCompanyNames>CB</ExcludeCompanyNames>
              <ExcludeJobTitles>janitor</ExcludeJobTitles>
              <ExcludeKeywords>moom</ExcludeKeywords>
              <Country>Merica</Country>
              <IndustryCodes>IN123</IndustryCodes>
              <JobTitle>nursing person</JobTitle>
              <Keywords>nurse</Keywords>
              <Location>ATL</Location>
              <OrderBy>date</OrderBy>
              <OrderDirection>up</OrderDirection>
              <PayHigh>100</PayHigh>
              <PayLow>2</PayLow>
              <PostedWithin>8</PostedWithin>
              <Radius>13</Radius>
              <SpecificEducation>true</SpecificEducation>
              <ExcludeNational>true</ExcludeNational>
              <PayInfoOnly>true</PayInfoOnly>
            </SearchParameters>
          eos
          end
        end
      end

      def add_search_params
        search_parameters.boolean_operator = 'AND'
        search_parameters.category = 'medical'
        search_parameters.education_code = 'EDU#1'
        search_parameters.emp_type = 'FullTime'
        search_parameters.exclude_company_names = 'CB'
        search_parameters.exclude_job_titles = 'janitor'
        search_parameters.exclude_keywords = 'moom'
        search_parameters.country = 'Merica'
        search_parameters.industry_codes = 'IN123'
        search_parameters.job_title = 'nursing person'
        search_parameters.keywords = 'nurse'
        search_parameters.location = 'ATL'
        search_parameters.order_by = 'date'
        search_parameters.order_direction = 'up'
        search_parameters.pay_high = 100
        search_parameters.pay_low = 2
        search_parameters.posted_within = 8
        search_parameters.radius = 13
        search_parameters.specific_education = true
        search_parameters.exclude_national = true
        search_parameters.pay_info_only = true
      end

      def mock_search_parameters_response
        '
        "BooleanOperator":"AND",
        "Category":"category",
        "EducationCode":"DRNS",
        "EmpType":"emptype",
        "ExcludeCompanyNames":"excludecompanynames",
        "ExcludeJobTitles":"excludejobtitles",
        "ExcludeKeywords":"excludekeywords",
        "ExcludeNational":false,
        "IndustryCodes":"industrycodes",
        "JobTitle":"jobtitle",
        "Keywords":"Sales",
        "Location":"Atlanta, GA",
        "OrderBy":"Distance",
        "OrderDirection":"descending",
        "PayHigh":0,
        "PayInfoOnly":false,
        "PayLow":0,
        "PostedWithin":30,
        "Radius":10,
        "SpecificEducation":false,
        "JCPositionLevel":"JC1",
        "JCLocation":"JC2",
        "JCAdvertiserFlags":"JC3",
        "JCJobNature":"JC4",
        "Company":"company",
        "City":"city",
        "State":"state",
        "Country":"country"
        '
      end
    end
  end
end
