require 'spec_helper'

module Cb
  describe Cb::SavedJobSearchApi do 
    context '.new' do 
      it 'should create a new saved job search api object' do 
        saved_search_request = Cb::SavedJobSearchApi.new
        saved_search_request.should be_a_kind_of(Cb::SavedJobSearchApi)
      end
    end

    context '.create_saved_search' do 
      it 'should send a successful request to the saved search api v2' do
        VCR.use_cassette('saved_search/successful_create_saved_search') do  
          dev_key = 'WDHS47J77WLS2Y0N102H'             
          email_frequency = 'None'
          external_id = 'XRHS3LN6G55WX61GXJG8'
          host_site = 'WR'
          search_name = 'Fake Job Search 2' 

          user_saved_search = Cb::CbSavedJobSearch.new(:DeveloperKey=>dev_key, :IsDailyEmail=>email_frequency, 
                                                        :ExternalUserId=>external_id, :SearchName=>search_name,
                                                        :HostSite=>host_site)

          saved_search_request = Cb.saved_job_search_api
          response = saved_search_request.create_saved_search(user_saved_search)

          response['SavedJobSearch']['Errors'].should be_nil

        end
      end

      it 'should send a faulty request to the saved search api' do 
        VCR.use_cassette('saved_search/unsuccessful_create_saved_search') do             
          email_frequency = 'None'
          external_id = 'XRHS3LN6G55WX61GXJG8'
          host_site = 'WR'
          search_name = 'Fake Job Search 2' 

          user_saved_search = Cb::CbSavedJobSearch.new( :IsDailyEmail=>email_frequency, 
                                                        :ExternalUserId=>external_id, :SearchName=>search_name,
                                                        :HostSite=>host_site)

          saved_search_request = Cb.saved_job_search_api
          response = saved_search_request.create_saved_search(user_saved_search)
          response['SavedJobSearch']['Errors'].should_not be_nil
        end
      end
    end
  end
end