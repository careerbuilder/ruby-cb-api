require 'spec_helper'

module Cb
  describe Cb::Models::SavedSearch do
    let(:saved_search) { Models::SavedSearch.new }
    let(:search_parameters) { Models::SavedSearch::SearchParameters.new }

    context '.new' do 
      it 'should create a new saved job search object with at least minimum required params' do
        email_frequency = 'None'
        external_id = 'XRHS3LN6G55WX61GXJG8'
        host_site = 'WR'
        search_name = 'Fake Job Search 2' 

        user_saved_search = Cb::Models::SavedSearch.new('IsDailyEmail'=>email_frequency,
                                                      'ExternalUserID'=>external_id, 'SearchName'=>search_name,
                                                      'HostSite'=>host_site)
        
        user_saved_search.should be_a_kind_of(Cb::Models::SavedSearch)
        user_saved_search.is_daily_email.should == email_frequency
        user_saved_search.host_site.should == host_site
        user_saved_search.search_name.should == search_name
        user_saved_search.external_user_id.should == external_id
        
      end
    end

    describe '#delete_to_xml' do
      before {
        saved_search.host_site = 'US'
        saved_search.external_id = 'BigMoom'
        saved_search.external_user_id = 'BigMoomGuy'
        Cb.configuration.dev_key = 'who dat'
      }
      it 'serialized correctly' do
        xml = saved_search.delete_to_xml
        expect(xml).to eq <<-eos
          <Request>
            <HostSite>US</HostSite>
            <ExternalID>BigMoom</ExternalID>
            <ExternalUserID>BigMoomGuy</ExternalUserID>
            <DeveloperKey>who dat</DeveloperKey>
          </Request>
        eos
      end
    end

    describe '#delete_anon_to_xml' do
      before {
        saved_search.external_id = 'BigMoom'
        Cb.configuration.dev_key = 'who dat'
      }
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

    describe '#create_to_xml' do
      before {
        saved_search.host_site = 'US'
        saved_search.cobrand = 'AOLer'
        saved_search.search_name = 'Yolo'
        add_search_params
        saved_search.search_parameters = search_parameters
        saved_search.is_daily_email = true
        saved_search.external_user_id = 'BigMoomGuy'
        Cb.configuration.dev_key = 'who dat'
      }
      it 'serialized correctly' do

        xml = saved_search.create_to_xml
        expect(xml).to eq <<-eos
          <Request>
            <HostSite>US</HostSite>
            <Cobrand>AOLer</Cobrand>
            <SearchName>Yolo</SearchName>
            #{search_parameters.to_xml}
            <IsDailyEmail>TRUE</IsDailyEmail>
            <ExternalUserID>BigMoomGuy</ExternalUserID>
            <DeveloperKey>who dat</DeveloperKey>
          </Request>
        eos
      end
    end

    describe '#create_anon_to_xml' do
      before {
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
      }
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

    describe '#update_to_xml' do
      before {
        saved_search.host_site = 'US'
        saved_search.cobrand = 'AOLer'
        saved_search.search_name = 'Yolo'
        add_search_params
        saved_search.search_parameters = search_parameters
        saved_search.is_daily_email = true
        saved_search.external_user_id = 'BigMoomGuy'
        saved_search.external_id = 'BigMoom'
        Cb.configuration.dev_key = 'who dat'
      }
      it 'serialized correctly' do

        xml = saved_search.update_to_xml
        expect(xml).to eq <<-eos
          <Request>
            <HostSite>US</HostSite>
            <Cobrand>AOLer</Cobrand>
            <SearchName>Yolo</SearchName>
            #{search_parameters.to_xml}
            <IsDailyEmail>TRUE</IsDailyEmail>
            <ExternalID>BigMoom</ExternalID>
            <ExternalUserID>BigMoomGuy</ExternalUserID>
            <DeveloperKey>who dat</DeveloperKey>
          </Request>
        eos
      end
    end

    def add_search_params
      search_parameters.boolean_operator = 'AND'
      search_parameters.category = 'medical'
      search_parameters.category = 'medical jobs'
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

  end
end