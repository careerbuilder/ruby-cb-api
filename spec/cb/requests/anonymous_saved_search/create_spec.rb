require 'spec_helper'

module Cb
  describe Cb::Requests::AnonymousSavedSearch::Create do

    context 'initialize without arguments' do
      it 'should not raise error' do
        request = Cb::Requests::AnonymousSavedSearch::Create.new({})
        expect { request.http_method }.to_not raise_error()
        expect { request.endpoint_uri }.to_not raise_error()
      end

      context 'without arguments' do
        before :each do
          @request = Cb::Requests::AnonymousSavedSearch::Create.new({})
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_anon_saved_search_create
          @request.http_method.should == :post
        end

        it 'should have a basic query string' do
          @request.query.should == nil
        end

        it 'should have basic headers' do
          @request.headers.should == nil
        end

        it 'should have a basic body' do
          @request.body.should == <<-eos
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
          @request = Cb::Requests::AnonymousSavedSearch::Create.new({
            host_site: 'host site',
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
            is_daily_email: true
          })
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_anon_saved_search_create
          @request.http_method.should == :post
        end

        it 'should have a basic query string' do
          @request.query.should == nil
        end

        it 'should have basic headers' do
          @request.headers.should == nil
        end

        it 'should have a basic body' do
          @request.body.should == <<-eos
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
