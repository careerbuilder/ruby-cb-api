require 'spec_helper'

module Cb
  describe Cb::SavedSearchApi do

    context '.new' do
      it 'should create a new saved job search api object' do
        saved_search_request = Cb::SavedSearchApi.new
        saved_search_request.should be_a_kind_of(Cb::SavedSearchApi)
      end
    end

    context '.create' do
      it 'should send a successful request to the saved search create api v2' do
        stub_request(:post, uri_stem(Cb.configuration.uri_saved_search_create)).
          with(:body => anything).
          to_return(:body => { SavedJobSearch: { Errors: nil, SavedSearch: Hash.new } }.to_json)

        email_frequency = 'None'
        search_name = 'Fake Job Search 1'

        user_saved_search = Cb.saved_search_api.create({'DeveloperKey'=>Cb.configuration.dev_key, 'IsDailyEmail'=>email_frequency,
                            'ExternalUserID'=>@external_user_id, 'SearchName'=>search_name,
                                  'HostSite'=>@host_site})
        user_saved_search.cb_response.errors.nil?.should be_true
        user_saved_search.api_error.should == false
      end

      it 'should fail to send a request to the saved search api v2',
        :pending => 'this test is not needed - just testing what happens on the API side when dev key is omitted' do
        VCR.use_cassette('saved_search/unsuccessful_create_saved_search') do
          email_frequency = 'None'
          search_name = 'Fake Job Search 2'

          user_saved_search = Cb.saved_search_api.create({'IsDailyEmail'=>email_frequency,
                                                          'ExternalUserID'=>@external_user_id, 'SearchName'=>search_name,
                                                          'HostSite'=>@host_site})
          puts "errors #{user_saved_search.cb_response.errors.to_s}"
          user_saved_search.cb_response.errors.nil?.should be_false
          user_saved_search.api_error.should == false
        end
      end
    end

    context '.update' do
      it 'should update the saved search created in this test' do
        stub_request(:post, uri_stem(Cb.configuration.uri_saved_search_update)).
          with(:body => anything).
          to_return(:body => { Errors: nil, SavedJobSearch: Hash.new }.to_json)

        external_id = 'xid'
        email_frequency = 'None'
        search_name = 'Fake Job Search Update'

        user_saved_search = Cb.saved_search_api.update({'DeveloperKey'=>Cb.configuration.dev_key, 'IsDailyEmail'=>email_frequency,
                                                        'ExternalUserID'=>@external_user_id, 'SearchName'=>search_name,
                                                        'HostSite'=>@host_site, 'ExternalID'=>external_id})

        user_saved_search.cb_response.errors.nil?.should be_true
        user_saved_search.api_error.should == false
      end
    end

    context '.list' do
      it 'should retrieve a list of saved searches',
        :pending => 'this test leads to a false positive. #list will always return not nil' do
        user_saved_search = Cb.saved_search_api.list(Cb.configuration.dev_key, @external_user_id, 'WM')

        user_saved_search.should_not be_nil
        expect(user_saved_search.api_error).to be == false
      end
    end

    context '.retrieve' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_saved_search_retrieve)).
          to_return(:body => { SavedJobSearch: { Errors: nil, SavedSearch: Hash.new } }.to_json)
      end

      it 'should retrieve the first saved search' do
        user_saved_search = Cb::SavedSearchApi.retrieve(Cb.configuration.dev_key, @external_user_id, 'xid', @host_site)

        expect(user_saved_search.cb_response.errors.nil?).to eq(true)
        expect(user_saved_search.api_error).to be == false
      end
    end

    context '.delete' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_saved_search_delete)).
          to_return(:body => { Request: { Errors: nil } }.to_json)
      end

      it 'should delete the first saved search' do
        user_saved_search = Cb.saved_search_api.delete({'DeveloperKey'=>Cb.configuration.dev_key, 'ExternalID'=>'xid','ExternalUserID'=>@external_user_id, 'HostSite'=>@host_site})

        user_saved_search.cb_response.errors.blank?.should == true
        user_saved_search.api_error.should == false
      end
    end

  end
end
