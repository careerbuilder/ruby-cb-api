require 'spec_helper'

module Cb
  describe Cb::CbSavedSearch do
    context '.new' do 
      it 'should create a new saved job search object with at least minimum required params' do

        dev_key = 'WDHS47J77WLS2Y0N102H'             
        email_frequency = 'None'
        external_id = 'XRHS3LN6G55WX61GXJG8'
        host_site = 'WR'
        search_name = 'Fake Job Search 2' 

        user_saved_search = Cb::CbSavedSearch.new(:DeveloperKey=>dev_key, :IsDailyEmail=>email_frequency,
                                                      :ExternalUserID=>external_id, :SearchName=>search_name,
                                                      :HostSite=>host_site)
        
        user_saved_search.should be_a_kind_of(Cb::CbSavedSearch)
        user_saved_search.dev_key.should == dev_key
        user_saved_search.is_daily_email.should == email_frequency
        user_saved_search.hostsite.should == host_site
        user_saved_search.search_name.should == search_name
        user_saved_search.external_user_id.should == external_id
        
      end
    end
  end
end