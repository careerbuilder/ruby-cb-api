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
    class SavedSearch
      attr_accessor :host_site, :cobrand, :site_id, :search_name, :boolean_operator, :category, :education_code, :specific_education,
                    :emp_type, :exclude_company_names, :exclude_job_titles, :exclude_national, :industry_codes,
                    :keywords, :order_by, :order_direction, :radius, :pay_high, :pay_low, :posted_within,
                    :pay_info_only, :location, :job_category, :company, :city, :state, :is_daily_email, :external_id,
                    :external_user_id, :job_search_url, :jrdid, :errors, :browser_id, :session_id, :test, :email_address,
                    :country, :search_parameters, :did, :user_oauth_token, :email_delivery_day

      def initialize(args = {})
        @host_site                  = args['HostSite'] || args[:host_site] || ''
        @cobrand                    = args['Cobrand'] || args[:cobrand] || ''
        @search_name                = args['SearchName'] || args[:search_name] || ''
        @site_id                    = args['SiteId'] || args[:site_id] || ''
        @is_daily_email             = args['IsDailyEmail'] || args[:is_daily_email] || false
        @email_delivery_day         = args['EmailDeliveryDay'] || args[:email_delivery_day] || ''
        @job_search_url             = args['JobSearchUrl'] || args[:job_search_url] || ''
        @external_id                = args['ExternalID'] || args[:external_id] || ''
        @external_user_id           = args['ExternalUserID'] || args[:external_user_id] || ''
        @browser_id                 = args['BrowserID'] || args[:browser_id] || nil
        @session_id                 = args['SessionID'] || args[:session_id] || ''
        @email_address              = args['EmailAddress'] || args[:email_address] || ''
        @did                        = args['DID'] || args[:did] || ''
        @user_oauth_token           = args['userOAuthToken'] || args[:user_oauth_token] || ''
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
        <<-eos
          <Request>
            <HostSite>#{host_site}</HostSite>
            <Cobrand>#{cobrand}</Cobrand>
            <BrowserID>#{browser_id}</BrowserID>
            <SessionID>#{session_id}</SessionID>
            <Test>false</Test>
            <EmailAddress>#{email_address}</EmailAddress>
            <SearchName>#{search_name}</SearchName>
            #{search_parameters.to_xml}
            <IsDailyEmail>#{is_daily_email.to_s.upcase}</IsDailyEmail>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
          </Request>
        eos
      end

      def update_to_json
        hash = {
          'DID' => did,
          'SearchName' => search_name,
          'HostSite' => host_site,
          'SiteID' => site_id,
          'Cobrand' => cobrand,
          'IsDailyEmail' => is_daily_email,
          'userOAuthToken' => user_oauth_token,
          'SavedSearchParameters' => search_parameters.to_hash
        }
        hash['EmailDeliveryDay'] = email_delivery_day unless is_daily_email
        hash.to_json
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
                      :city, :state, :country, :company, :job_category,
                      :jc_position_level, :jc_location, :jc_advertiser_flags, :jc_job_nature

        def initialize(args = {})
          @boolean_operator      = args['BooleanOperator'] || ''
          @category              = args['Category'] || ''
          @job_category          = args['JobCategory'] || ''
          @education_code        = args['EducationCode'] || ''
          @emp_type              = args['EmpType'] || ''
          @exclude_company_names = args['ExcludeCompanyNames'] || ''
          @exclude_job_titles    = args['ExcludeJobTitles'] || ''
          @exclude_keywords      = args['ExcludeKeywords'] || ''
          @exclude_national      = args['ExcludeNational'].nil? ? false : args['ExcludeNational']
          @industry_codes        = args['IndustryCodes'] || ''
          @job_title             = args['JobTitle'] || ''
          @keywords              = args['Keywords'] || ''
          @location              = args['Location'] || ''
          @order_by              = args['OrderBy'] || ''
          @order_direction       = args['OrderDirection'] || ''
          @pay_high              = args['PayHigh'] || 0
          @pay_low               = args['PayLow'] || 0
          @pay_info_only         = args['PayInfoOnly'].nil? ? false : args['PayInfoOnly']
          @posted_within         = args['PostedWithin'] || 30
          @radius                = args['Radius'] || 30
          @specific_education    = args['SpecificEducation'].nil? ? false : args['SpecificEducation']
          @city                  = args['City'] || ''
          @state                 = args['State'] || ''
          @country               = args['Country'] || ''
          @company               = args['Company'] || ''
          @jc_position_level     = args['JCPositionLevel'] || ''
          @jc_location           = args['JCLocation'] || ''
          @jc_advertiser_flags   = args['JCAdvertiserFlags'] || ''
          @jc_job_nature         = args['JCJobNature'] || ''
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

        def to_hash
          {
            'BooleanOperator' => boolean_operator,
            'JobCategory' => job_category,
            'EducationCode' => education_code,
            'EmpType' => emp_type,
            'ExcludeCompanyNames' => exclude_company_names,
            'ExcludeJobTitles' => exclude_job_titles,
            'Country' => country,
            'IndustryCodes' => industry_codes,
            'JobTitle' => job_title,
            'Keywords' => keywords,
            'Location' => location,
            'OrderBy' => order_by,
            'OrderDirection' => order_direction,
            'PayHigh' => pay_high,
            'PayLow' => pay_low,
            'PostedWithin' => posted_within,
            'Radius' => radius,
            'SpecificEducation' => specific_education,
            'ExcludeNational' => exclude_national,
            'PayInfoOnly' => pay_info_only
          }
        end
      end
    end
  end
end
