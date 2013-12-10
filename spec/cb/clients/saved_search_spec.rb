require 'spec_helper'

module Cb
  describe Cb::Clients::SavedSearch do

    context '.new' do
      it 'should create a new saved job search api object' do
        saved_search_request = Cb::Clients::SavedSearch.new
        saved_search_request.should be_a_kind_of(Cb::Clients::SavedSearch)
      end
    end

    context '.create' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_saved_search_create)).
          with(:body => anything).
          to_return(:body => { SavedJobSearch: { Errors: nil, SavedSearch: Hash.new } }.to_json)
      end

      it 'should send a successful request to the saved search create api v2' do
        email_frequency = 'None'
        search_name = 'Fake Job Search 1'

        user_saved_search = Cb.saved_search.create({'DeveloperKey'=>Cb.configuration.dev_key, 'IsDailyEmail'=>email_frequency,
                            'ExternalUserID'=>@external_user_id, 'SearchName'=>search_name,
                                  'HostSite'=>@host_site})
        user_saved_search.cb_response.errors.nil?.should be_true
        user_saved_search.api_error.should == false
      end
    end

    context '.update' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_saved_search_update)).
          with(:body => anything).
          to_return(:body => { Errors: nil, SavedJobSearch: Hash.new }.to_json)
      end

      it 'should update the saved search created in this test' do
        external_id = 'xid'
        email_frequency = 'None'
        search_name = 'Fake Job Search Update'

        user_saved_search = Cb.saved_search.update({'DeveloperKey'=>Cb.configuration.dev_key, 'IsDailyEmail'=>email_frequency,
                                                        'ExternalUserID'=>@external_user_id, 'SearchName'=>search_name,
                                                        'HostSite'=>@host_site, 'ExternalID'=>external_id})

        user_saved_search.cb_response.errors.nil?.should be_true
        user_saved_search.api_error.should == false
      end
    end

    context '.list' do
      def stub_api_to_return(content)
        stub_request(:get, uri_stem(Cb.configuration.uri_saved_search_list)).
          to_return(:body => content.to_json)
      end

      context 'when the saved search node contains a hash' do
        before(:each) { stub_api_to_return({ SavedJobSearches: { SavedSearches: { SavedSearch: { a: 'b', b: 'c' } } } }) }

        it 'should return an array with a single saved search' do
          user_saved_search = Cb.saved_search.list(Cb.configuration.dev_key, @external_user_id, 'WM')

          expect(user_saved_search).to be_an_instance_of Array
          expect(user_saved_search.first).to be_an_instance_of Cb::CbSavedSearch
          expect(user_saved_search.api_error).to be == false
        end
      end

      context 'when the saved search node contains an array' do
        before(:each) { stub_api_to_return({ SavedJobSearches: { SavedSearches: { SavedSearch: [Hash.new, Hash.new] } } }) }

        it 'should return an array of saved searches' do
          user_saved_search = Cb.saved_search.list(Cb.configuration.dev_key, @external_user_id, 'WM')

          expect(user_saved_search).to be_an_instance_of Array
          expect(user_saved_search.first).to be_an_instance_of Cb::CbSavedSearch
          expect(user_saved_search[1]).to be_an_instance_of Cb::CbSavedSearch
          expect(user_saved_search.api_error).to be == false
        end
      end
    end

    context '.retrieve' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_saved_search_retrieve)).
          to_return(:body => { SavedJobSearch: { Errors: nil, SavedSearch: Hash.new } }.to_json)
      end

      it 'should retrieve the first saved search' do
        user_saved_search = Cb::Clients::SavedSearch.retrieve(Cb.configuration.dev_key, @external_user_id, 'xid', @host_site)

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
        user_saved_search = Cb.saved_search.delete({'DeveloperKey'=>Cb.configuration.dev_key, 'ExternalID'=>'xid','ExternalUserID'=>@external_user_id, 'HostSite'=>@host_site})

        user_saved_search.cb_response.errors.blank?.should == true
        user_saved_search.api_error.should == false
      end
    end

  end
end
