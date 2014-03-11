require 'xmlsimple'

module Cb
  module Models
    class SavedSearch
      attr_accessor :host_site, :cobrand, :site_id, :search_name, :boolean_operator, :category, :education_code, :specific_education,
                    :emp_type, :exclude_company_names, :exclude_job_titles, :exclude_national, :industry_codes,
                    :keywords, :order_by, :order_direction, :radius, :pay_high, :pay_low, :posted_within,
                    :pay_info_only, :location, :job_category, :company, :city, :state, :is_daily_email, :external_id,
                    :external_user_id, :job_search_url, :jrdid, :errors, :browser_id, :session_id, :test, :email_address,
                    :saved_search_parameters, :country, :search_parameters

      def initialize(args={})
        @host_site                  = args['HostSite']         || String.new
        @cobrand                    = args['Cobrand']          || String.new
        @search_name                = args['SearchName']       || String.new
        @site_id                    = args['SiteId']           || String.new
        @is_daily_email             = args['IsDailyEmail']     || String.new
        @email_delivery_day         = args['EmailDeliveryDay'] || String.new
        @external_id                = args['ExternalID']       || String.new
        @external_user_id           = args['ExternalUserID']   || String.new
        @browser_id                 = args['BrowserID']        || nil
        @session_id                 = args['SessionID']        || String.new
        @email_address              = args['EmailAddress']     || String.new
        @search_parameters          = SearchParameters.new(args['SavedSearchParameters'] || {})
      end

      def create_to_xml
        <<-eos
          <Request>
            <HostSite>#{host_site}</HostSite>
            <Cobrand>#{cobrand}</Cobrand>
            <SearchName>#{search_name}</SearchName>
            #{search_parameters.to_xml}
            <IsDailyEmail>#{is_daily_email.to_s.upcase}</IsDailyEmail>
            <ExternalUserID>#{external_user_id}</ExternalUserID>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
          </Request>
        eos
      end

      def create_anon_to_xml
        ret =  "<Request>"
        ret += "<HostSite>#{@hostsite}</HostSite>"
        ret += "<Cobrand>#{@cobrand}</Cobrand>"
        ret += "<BrowserID>#{@browser_id}</BrowserID>"
        ret += "<SessionID>#{@session_id}</SessionID>"
        ret += "<Test>#{false}</Test>"
        ret += "<EmailAddress>#{@email_address}</EmailAddress>"
        ret += "<SearchName>#{@search_name}</SearchName>"
        ret += search_parameters.to_xml
        ret += "<IsDailyEmail>#{@is_daily_email.to_s.upcase}</IsDailyEmail>"
        ret += "<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
        ret + "</Request>"
      end

      def update_to_xml
        ret =  "<Request>"
        ret += "<HostSite>#{@hostsite}</HostSite>"
        ret += "<Cobrand>#{@cobrand}</Cobrand>"
        ret += "<SearchName>#{@search_name}</SearchName>"
        ret += search_parameters.to_xml
        ret += "<IsDailyEmail>#{@is_daily_email.to_s.upcase}</IsDailyEmail>"
        ret += "<ExternalID>#{@external_id}</ExternalID>"
        ret += "<ExternalUserID>#{@external_user_id}</ExternalUserID>"
        ret += "<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
        ret + "</Request>"
      end

      def delete_to_xml
        <<-eos
          <Request>
            <HostSite>#{host_site}</HostSite>
            <ExternalID>#{external_id}</ExternalID>
            <ExternalUserID>#{external_user_id}</ExternalUserID>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
          </Request>
        eos
      end

      def delete_anon_to_xml
        <<-eos
          <Request>
            <ExternalID>#{external_id}</ExternalID>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <Test>false</Test>
          </Request>
        eos
      end

      class Delete
        attr_reader :status

        def initialize(response)
          @status = response['Status']
        end
      end

      class SearchParameters
        attr_accessor :boolean_operator, :category, :education_code, :emp_type, :exclude_company_names, :exclude_job_titles,
                      :exclude_keywords, :exclude_national, :industry_codes, :job_title, :keywords, :location, :order_by,
                      :order_direction, :pay_high, :pay_info_only, :pay_low, :posted_within, :radius, :specific_education,
                      :country

        def initialize(args = {})
          @boolean_operator      = args['BooleanOperator']     || String.new
          @category              = args['Category']            || String.new
          @job_category          = args['JobCategory']         || String.new
          @education_code        = args['EducationCode']       || String.new
          @emp_type              = args['EmpType']             || String.new
          @exclude_company_names = args['ExcludeCompanyNames'] || String.new
          @exclude_job_titles    = args['ExcludeJobTitles']    || String.new
          @exclude_keywords      = args['ExcludeKeywords']     || String.new
          @country               = args['Country']             || String.new
          @industry_codes        = args['IndustryCodes']       || String.new
          @job_title             = args['JobTitle']            || String.new
          @keywords              = args['Keywords']            || String.new
          @location              = args['Location']            || String.new
          @order_by              = args['OrderBy']             || String.new
          @order_direction       = args['OrderDirection']      || String.new
          @pay_high              = args['PayHigh']             || 0
          @pay_low               = args['PayLow']              || 0
          @posted_within         = args['PostedWithin']        || 30
          @radius                = args['Radius']              || 30
          @specific_education    = args['SpecificEducation'].nil? ? false : args['SpecificEducation']
          @exclude_national      = args['ExcludeNational'].nil?   ? false : args['ExcludeNational']
          @pay_info_only         = args['PayInfoOnly'].nil?       ? false : args['PayInfoOnly']
        end

        def to_xml
          <<-eos
            <SearchParameters>
              <BooleanOperator>#{boolean_operator}</BooleanOperator>
              <JobCategory>#{category}</JobCategory>
              <EducationCode>#{education_code}</EducationCode>
              <EmpType>#{emp_type}</EmpType>
              <ExcludeCompanyNames>#{exclude_company_names}</ExcludeCompanyNames>
              <ExcludeJobTitles>#{exclude_job_titles}</ExcludeJobTitles>
              <ExcludeKeywords>#{exclude_keywords}</ExcludeKeywords>
              <Country>#{country}</Country>
              <IndustryCodes>#{industry_codes}</IndustryCodes>
              <JobTitle>#{job_title}</JobTitle>
              <Keywords>#{keywords}</Keywords>
              <Location>#{location}</Location>
              <OrderBy>#{order_by}</OrderBy>
              <OrderDirection>#{order_direction}</OrderDirection>
              <PayHigh>#{pay_high}</PayHigh>
              <PayLow>#{pay_low}</PayLow>
              <PostedWithin>#{posted_within}</PostedWithin>
              <Radius>#{radius}</Radius>
              <SpecificEducation>#{specific_education}</SpecificEducation>
              <ExcludeNational>#{exclude_national}</ExcludeNational>
              <PayInfoOnly>#{pay_info_only}</PayInfoOnly>
            </SearchParameters>
          eos
        end
      end
    end

  end
end
