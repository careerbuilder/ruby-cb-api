require 'spec_helper'

module Cb
  describe Cb::Models::SavedSearch do
    let(:saved_search) { Models::SavedSearch.new }

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

  end
end