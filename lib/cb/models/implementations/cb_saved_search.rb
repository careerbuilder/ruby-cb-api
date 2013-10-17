require 'nokogiri'
module Cb
  class CbSavedSearch
    attr_accessor :hostsite, :cobrand, :site_id, :search_name, :boolean_operator, :category, :education_code, :specific_education,
                  :emp_type, :exclude_company_names, :exclude_job_titles, :exclude_national, :industry_codes,
                  :keywords, :order_by, :order_direction, :radius, :pay_high, :pay_low, :posted_within, 
                  :pay_info_only, :location, :job_category, :company, :city, :state, :is_daily_email, :external_id,
                  :external_user_id, :dev_key, :job_search_url, :jrdid, :errors, :browser_id, :session_id, :test, :email_address,
                  :saved_search_parameters

    def initialize(args={})
      @hostsite                   = args['HostSite'] || ''
      @cobrand                    = args['Cobrand'] || ''
      @search_name                = args['SearchName'] || ''
      @site_id                    = args['SiteId'] || ''
      @boolean_operator           = args['BooleanOperator'] || ''
      @category                   = args['Category'] || ''
      @education_code             = args['EducationCode'] || ''
      @specific_education         = args['SpecificEducation'] || false
      @emp_type                   = args['EmpType'] || ''
      @exclude_company_names      = args['ExcludeCompanyNames'] || ''
      @exclude_job_titles         = args['ExcludeJobTitles'] || ''
      @exclude_national           = args['ExcludeNational'] || false
      @industry_codes             = args['IndustryCodes'] || ''
      @keywords                   = args['Keywords'] || ''
      @order_by                   = args['OrderBy'] || ''
      @order_direction            = args['OrderDirection'] || ''
      @radius                     = args['Radius'] || 30
      @pay_high                   = args['PayHigh'] || 0
      @pay_low                    = args['PayLow'] ||  0
      @posted_within              = args['PostedWithin'] || 30
      @pay_info_only              = args['PayInfoOnly'] || false
      @location                   = args['Location'] || ''
      @job_category               = args['JobCategory'] || ''
      @company                    = args['Company'] || ''
      @city                       = args['City'] || ''
      @state                      = args['State'] || ''
      @is_daily_email             = args['IsDailyEmail'] || ''
      @email_delivery_day         = args['EmailDeliveryDay'] || ''
      @external_id                = args['ExternalID'] || ''
      @external_user_id           = args['ExternalUserID'] || ''
      @dev_key                    = args['DeveloperKey'] || ''
      @job_search_url             = args['JobSearchUrl'] || ''
      @jrdid                      = args['JRDID'] || ''
      @errors                     = args['Errors'] || nil
      @browser_id                 = args['BrowserID'] || nil
      @session_id                 = args['SessionID'] || ''
      @test                       = args['Test'].to_s || false
      @email_address              = args['EmailAddress'] || ''
      if args.has_key?('SavedSearchParameters')
        unless args['SavedSearchParameters'].empty?
          @saved_search_parameters  = CbSavedSearch.new(args['SavedSearchParameters'])
        end
      end
    end

    class CbSavedSearchParameters
      attr_accessor :boolean_operator, :category, :education_code, :emp_type, :exclude_company_names, :exclude_job_titles,
                    :exclude_keywords, :exclude_national, :industry_codes, :job_title, :keywords, :location, :order_by,
                    :order_direction, :pay_high, :pay_info_only, :pay_low, :posted_within, :radius, :specific_education

      def initialize(args = {})
          @boolean_operator           = args['BooleanOperator'] || ''
          @category                   = args['Category'] || ''
          @education_code             = args['EducationCode'] || ''
          @emp_type                   = args['EmpType'] || ''
          @exclude_company_names      = args['ExcludeCompanyNames'] || ''
          @exclude_job_titles         = args['ExcludeJobTitles'] || ''
          @exclude_keywords           = args['ExcludeKeywords'] || ''
          @exclude_national           = args['ExcludeNational'] || false
          @industry_codes             = args['IndustryCodes'] || ''
          @job_title                  = args['Jobtitle'] || ''
          @keywords                   = args['Keywords'] || ''
          @location                   = args['Location'] || ''
          @order_by                   = args['OrderBy'] || ''
          @order_direction            = args['OrderDirection'] || ''
          @pay_high                   = args['PayHigh'] || 0
          @pay_info_only              = args['PayInfoOnly'] || false
          @pay_low                    = args['PayLow'] ||  0
          @posted_within              = args['PostedWithin'] || 30
          @radius                     = args['Radius'] || 30
          @specific_education         = args['SpecificEducation'] || false
      end
    end #CbSavedSearchParameters

    def create_to_xml
      ret =  "<Request>"
      ret += "<HostSite>#{@hostsite}</HostSite>"
      ret += "<Cobrand>#{@cobrand}</Cobrand>"
      ret += "<SearchName>#{@search_name}</SearchName>"
      ret += "<SearchParameters>"
      ret += "<BooleanOperator>#{@boolean_operator}</BooleanOperator>"
      ret += "<Category>#{@category}</Category>"
      ret += "<EducationCode>#{@education_code}</EducationCode>"
      ret += "<SpecificEducation>#{@specific_education}</SpecificEducation>"
      ret += "<EmpType>#{@emp_type}</EmpType>"
      ret += "<ExcludeCompanyNames>#{@exclude_company_names}</ExcludeCompanyNames>"
      ret += "<ExcludeJobTitles>#{@exclude_job_titles}</ExcludeJobTitles>"
      ret += "<ExcludeNational>#{@exclude_national}</ExcludeNational>"
      ret += "<IndustryCodes>#{@industry_codes}</IndustryCodes>"
      ret += "<Keywords>#{@keywords}</Keywords>"
      ret += "<OrderBy>#{@order_by}</OrderBy>"
      ret += "<OrderDirection>#{@order_direction}</OrderDirection>"
      ret += "<Radius>#{@radius}</Radius>"
      ret += "<PayHigh>#{@pay_high}</PayHigh>"
      ret += "<PayLow>#{@pay_high}</PayLow>"
      ret += "<PostedWithin>#{@posted_within}</PostedWithin>"
      ret += "<PayInfoOnly>#{@pay_info_only}</PayInfoOnly>"
      ret += "<Location>#{@location}</Location>"
      ret += "<JobCategory>#{@job_category}</JobCategory>"
      ret += "<Company>#{@company}</Company>"
      ret += "<City>#{@city}</City>"
      ret += "<State>#{@state}</State>"
      ret += "</SearchParameters>"
      ret += "<IsDailyEmail>#{@is_daily_email.upcase}</IsDailyEmail>"
      ret += "<ExternalUserID>#{@external_user_id}</ExternalUserID>"
      ret += "<DeveloperKey>#{@dev_key}</DeveloperKey>"
      ret += "</Request>"

      ret
    end

    def create_anon_to_xml
      ret =  "<Request>"
      ret += "<HostSite>#{@hostsite}</HostSite>"
      ret += "<Cobrand>#{@cobrand}</Cobrand>"
      ret += "<BrowserID>#{@browser_id}</BrowserID>"
      ret += "<SessionID>#{@session_id}</SessionID>"
      ret += "<Test>#{@test}</Test>"
      ret += "<EmailAddress>#{@email_address}</EmailAddress>"
      ret += "<SearchName>#{@search_name}</SearchName>"
      ret += "<SearchParameters>"
      ret += "<BooleanOperator>#{@boolean_operator}</BooleanOperator>"
      ret += "<Category>#{@category}</Category>"
      ret += "<EducationCode>#{@education_code}</EducationCode>"
      ret += "<SpecificEducation>#{@specific_education}</SpecificEducation>"
      ret += "<EmpType>#{@emp_type}</EmpType>"
      ret += "<ExcludeCompanyNames>#{@exclude_company_names}</ExcludeCompanyNames>"
      ret += "<ExcludeJobTitles>#{@exclude_job_titles}</ExcludeJobTitles>"
      ret += "<ExcludeNational>#{@exclude_national}</ExcludeNational>"
      ret += "<IndustryCodes>#{@industry_codes}</IndustryCodes>"
      ret += "<Keywords>#{@keywords}</Keywords>"
      ret += "<OrderBy>#{@order_by}</OrderBy>"
      ret += "<OrderDirection>#{@order_direction}</OrderDirection>"
      ret += "<Radius>#{@radius}</Radius>"
      ret += "<PayHigh>#{@pay_high}</PayHigh>"
      ret += "<PayLow>#{@pay_high}</PayLow>"
      ret += "<PostedWithin>#{@posted_within}</PostedWithin>"
      ret += "<PayInfoOnly>#{@pay_info_only}</PayInfoOnly>"
      ret += "<Location>#{@location}</Location>"
      ret += "<JobCategory>#{@job_category}</JobCategory>"
      ret += "<Company>#{@company}</Company>"
      ret += "<City>#{@city}</City>"
      ret += "<State>#{@state}</State>"
      ret += "</SearchParameters>"
      ret += "<IsDailyEmail>#{@is_daily_email.upcase}</IsDailyEmail>"
      ret += "<DeveloperKey>#{@dev_key}</DeveloperKey>"
      ret += "</Request>"

      ret
    end

    def update_to_xml
      ret =  "<Request>"
      ret += "<HostSite>#{@hostsite}</HostSite>"
      ret += "<Cobrand>#{@cobrand}</Cobrand>"
      ret += "<SearchName>#{@search_name}</SearchName>"
      ret += "<SearchParameters>"
      ret += "<BooleanOperator>#{@boolean_operator}</BooleanOperator>"
      ret += "<Category>#{@category}</Category>"
      ret += "<EducationCode>#{@education_code}</EducationCode>"
      ret += "<SpecificEducation>#{@specific_education}</SpecificEducation>"
      ret += "<EmpType>#{@emp_type}</EmpType>"
      ret += "<ExcludeCompanyNames>#{@exclude_company_names}</ExcludeCompanyNames>"
      ret += "<ExcludeJobTitles>#{@exclude_job_titles}</ExcludeJobTitles>"
      ret += "<ExcludeNational>#{@exclude_national}</ExcludeNational>"
      ret += "<IndustryCodes>#{@industry_codes}</IndustryCodes>"
      ret += "<Keywords>#{@keywords}</Keywords>"
      ret += "<OrderBy>#{@order_by}</OrderBy>"
      ret += "<OrderDirection>#{@order_direction}</OrderDirection>"
      ret += "<Radius>#{@radius}</Radius>"
      ret += "<PayHigh>#{@pay_high}</PayHigh>"
      ret += "<PayLow>#{@pay_high}</PayLow>"
      ret += "<PostedWithin>#{@posted_within}</PostedWithin>"
      ret += "<PayInfoOnly>#{@pay_info_only}</PayInfoOnly>"
      ret += "<Location>#{@location}</Location>"
      ret += "<JobCategory>#{@job_category}</JobCategory>"
      ret += "<Company>#{@company}</Company>"
      ret += "<City>#{@city}</City>"
      ret += "<State>#{@state}</State>"
      ret += "</SearchParameters>"
      ret += "<IsDailyEmail>#{@is_daily_email}</IsDailyEmail>"
      ret += "<ExternalID>#{@external_id}</ExternalID>"
      ret += "<ExternalUserID>#{@external_user_id}</ExternalUserID>"
      ret += "<DeveloperKey>#{@dev_key}</DeveloperKey>"
      ret += "</Request>"

      ret
    end

    def delete_to_xml
      ret =  "<Request>"
      ret += "<HostSite>#{@hostsite}</HostSite>"
      ret += "<ExternalID>#{@external_id}</ExternalID>"
      ret += "<ExternalUserID>#{@external_user_id}</ExternalUserID>"
      ret += "<DeveloperKey>#{@dev_key}</DeveloperKey>"
      ret += "</Request>"

      ret
    end

    def delete_anon_to_xml
      ret =   "<Request>"
      ret += "<DeveloperKey>#{@dev_key}</DeveloperKey>"
      ret += "<ExternalID>#{@external_id}</ExternalID>"
      ret += "<Test>#{@test}</Test>"
      ret += "</Request>"

      ret
    end
  end
end