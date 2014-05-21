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
            <HostSite>#{@args[:host_site]}</HostSite>
            <Cobrand>#{@args[:cobrand]}</Cobrand>
            <BrowserID>#{@args[:browser_id]}</BrowserID>
            <SessionID>#{@args[:session_id]}</SessionID>
            <Test>false</Test>
            <EmailAddress>#{@args[:email_address]}</EmailAddress>
            <SearchName>#{@args[:search_name]}</SearchName>
            #{search_parameters(@args[:search_parameters])}
            <IsDailyEmail>#{@args[:is_daily_email]}</IsDailyEmail>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
          </Request>
          eos
        end

        private

        def search_parameters(args)
          <<-eos
            <SearchParameters>
              <BooleanOperator>#{args[:boolean_operator]}</BooleanOperator>
              <JobCategory>#{args[:category]}</JobCategory>
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
