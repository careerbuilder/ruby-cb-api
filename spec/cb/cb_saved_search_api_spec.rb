require 'spec_helper'

module Cb
  describe Cb::SavedSearchApi do

    # Email address for this user: captainmorgantest@careerbuilder.com
    @@external_user_id = 'XRHS30G60RWSQ5P1S8RG'
    @@host_site = 'US'

    context '.new' do
      it 'should create a new saved job search api object' do
        saved_search_request = Cb::SavedSearchApi.new
        saved_search_request.should be_a_kind_of(Cb::SavedSearchApi)
      end
    end

    context '.create' do
      it 'should send a successful request to the saved search create api v2' do
        VCR.use_cassette('saved_search/successful_create_saved_search') do
          email_frequency = 'None'
          search_name = 'Fake Job Search 1'

          user_saved_search = Cb.saved_search_api.create({'DeveloperKey'=>Cb.configuration.dev_key, 'IsDailyEmail'=>email_frequency,
                              'ExternalUserID'=>@@external_user_id, 'SearchName'=>search_name,
                                    'HostSite'=>@@host_site})
     
          user_saved_search.cb_response.errors.nil?.should be_true
          user_saved_search.api_error.should == false
        end
      end

      it 'should fail to send a request to the saved search api v2' do
        VCR.use_cassette('saved_search/unsuccessful_create_saved_search') do
          email_frequency = 'None'
          search_name = 'Fake Job Search 2'

          user_saved_search = Cb.saved_search_api.create({'IsDailyEmail'=>email_frequency,
                                                          'ExternalUserID'=>@@external_user_id, 'SearchName'=>search_name,
                                                          'HostSite'=>@@host_site})

          user_saved_search.cb_response.errors.nil?.should be_false
          user_saved_search.api_error.should == false
        end
      end

      it 'should set api error on bogus request', :vcr => { :cassette_name => 'saved_search/create_bogus_request'} do
        correct_url = Cb.configuration.uri_saved_search_create

        Cb.configuration.uri_saved_search_create = Cb.configuration.uri_saved_search_create + 'a'
        saved_search = Cb.saved_search_api.create({'IsDailyEmail'=>'None',
                                                        'ExternalUserID'=>@@external_user_id, 'SearchName'=>'FakeJobSearch3',
                                                        'HostSite'=>@@host_site})
        Cb.configuration.uri_saved_search_create = correct_url

        saved_search.nil?.should be_true
        saved_search.api_error.should == true

      end
    end

    context '.update' do
      it 'should update the saved search created in this test' do
        VCR.use_cassette('saved_search/successful_update_saved_search') do
          saved_search_list = Cb::SavedSearchApi.list(Cb.configuration.dev_key, @@external_user_id)

          saved_search_list.api_error.should == false

          external_id = saved_search_list.first.external_id
          email_frequency = 'None'
          search_name = 'Fake Job Search Update'

          user_saved_search = Cb.saved_search_api.update({'DeveloperKey'=>Cb.configuration.dev_key, 'IsDailyEmail'=>email_frequency,
                                                          'ExternalUserID'=>@@external_user_id, 'SearchName'=>search_name,
                                                          'HostSite'=>@@host_site, 'ExternalID'=>external_id})
         
          user_saved_search.cb_response.errors.nil?.should be_true
          user_saved_search.api_error.should == false

        end
      end

      it 'should set api error on bogus request', :vcr => { :cassette_name => 'saved_search/update_bogus_request' } do
        correct_url = Cb.configuration.uri_saved_search_update

        Cb.configuration.uri_saved_search_update = Cb.configuration.uri_saved_search_update + 'a'
        saved_search = Cb.saved_search_api.update({'DeveloperKey'=>Cb.configuration.dev_key, 'IsDailyEmail'=>'None',
                                                        'ExternalUserID'=>@@external_user_id, 'SearchName'=>'Fake Search Update 2',
                                                        'HostSite'=>@@host_site, 'ExternalID'=>'bogus'})
        Cb.configuration.uri_saved_search_update = correct_url

        saved_search.nil?.should be_true
        saved_search.api_error.should == true

      end
    end

    context '.list' do
      it 'should retrieve a list of saved searches' do
        VCR.use_cassette('saved_search/successful_list_saved_search') do
          user_saved_search = Cb.saved_search_api.list(Cb.configuration.dev_key, @@external_user_id)

          user_saved_search.should_not be_nil
          expect(user_saved_search.api_error).to be == false
        end
      end

      it 'should set api error on bogus request', :vcr => { :cassette_name => 'saved_search/list_bogus_request' } do
        correct_url = Cb.configuration.uri_saved_search_list

        Cb.configuration.uri_saved_search_list = Cb.configuration.uri_saved_search_list + 'a'
        saved_search = Cb.saved_search_api.list(Cb.configuration.dev_key, @@external_user_id)
        Cb.configuration.uri_saved_search_list = correct_url

        saved_search.empty?.should be_true
        saved_search.api_error.should == true

      end
    end

    context '.retrieve' do
      it 'should retrieve the first saved search' do
        VCR.use_cassette('saved_search/successful_retrieve_saved_search') do
          saved_search_list = Cb::SavedSearchApi.list(Cb.configuration.dev_key, @@external_user_id)
          expect(saved_search_list.api_error).to be == false

          external_id = saved_search_list.first.external_id

          user_saved_search = Cb::SavedSearchApi.retrieve(Cb.configuration.dev_key, @@external_user_id, external_id, @@host_site)

          expect(user_saved_search.cb_response.errors.nil?).to eq(true)
          expect(user_saved_search.api_error).to be == false

        end
      end

      it 'should set api error on bogus request', :vcr => { :cassette_name => 'saved_search/retrieve_bogus_request' } do
        correct_url = Cb.configuration.uri_saved_search_retrieve

        Cb.configuration.uri_saved_search_retrieve = Cb.configuration.uri_saved_search_retrieve + 'a'
        saved_search = Cb::SavedSearchApi.retrieve(Cb.configuration.dev_key, @@external_user_id, "bogus", @@host_site)
        Cb.configuration.uri_saved_search_retrieve = correct_url

        saved_search.nil?.should be_true
        saved_search.api_error.should == true

      end
    end

    context '.delete' do
      it 'should delete the first saved search' do
        VCR.use_cassette('saved_search/successful_delete_saved_search') do
          saved_search_list = Cb::SavedSearchApi.list(Cb.configuration.dev_key, @@external_user_id)
          saved_search_list.api_error.should == false

          external_id = saved_search_list.first.external_id

          user_saved_search = Cb.saved_search_api.delete({'DeveloperKey'=>Cb.configuration.dev_key, 'ExternalID'=>external_id,'ExternalUserID'=>@@external_user_id, 'HostSite'=>@@host_site})

          user_saved_search.cb_response.errors.blank?.should == true
          user_saved_search.api_error.should == false
        end
      end

      it 'should set api error on bogus request', :vcr => { :cassette_name => 'saved_search/delete_bogus_request' } do
        correct_url = Cb.configuration.uri_saved_search_delete

        Cb.configuration.uri_saved_search_delete = Cb.configuration.uri_saved_search_delete + 'a'
        saved_search = Cb.saved_search_api.delete({'DeveloperKey'=>Cb.configuration.dev_key, 'ExternalID'=>"bogus",'ExternalUserID'=>@@external_user_id, 'HostSite'=>@@host_site})
        Cb.configuration.uri_saved_search_delete = correct_url

        saved_search.nil?.should be_true
        saved_search.api_error.should == true

      end
    end

  end
end