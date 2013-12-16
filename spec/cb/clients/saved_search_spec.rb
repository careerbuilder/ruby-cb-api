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

      it 'should return a saved search retrieve response' do
        email_frequency = 'None'
        search_name = 'Fake Job Search 1'
        model = Models::SavedSearch.new({'DeveloperKey' => Cb.configuration.dev_key, 'IsDailyEmail' => email_frequency,
                                         'ExternalUserID' => @external_user_id, 'SearchName' => search_name,
                                         'HostSite' => @host_site})

        Cb.saved_search.new.create(model).class.should eq Responses::SavedSearch::Retrieve
      end
    end

    context '.update' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_saved_search_update)).
          with(:body => anything).
          to_return(:body => { Errors: nil, SavedJobSearch: { SavedSearch: Hash.new } }.to_json)
      end

      it 'should update the saved search created in this test' do
        external_id = 'xid'
        email_frequency = 'None'
        search_name = 'Fake Job Search Update'
        model = Models::SavedSearch.new({'DeveloperKey' => Cb.configuration.dev_key, 'IsDailyEmail' => email_frequency,
                                         'ExternalUserID' => @external_user_id, 'SearchName' => search_name,
                                         'HostSite' => @host_site, 'ExternalID' => external_id})

        response = Cb.saved_search.new.update(model)
        response.model.class.should eq Models::SavedSearch
      end
    end

    context '.list' do
      def stub_api_to_return(content)
        stub_request(:get, uri_stem(Cb.configuration.uri_saved_search_list)).
          to_return(:body => content.to_json)
      end

      context 'when the saved search node contains a hash' do
        before(:each) { stub_api_to_return({ SavedJobSearches: { SavedSearches: { SavedSearch: { a: 'b', b: 'c' } } } }) }

        it 'should return an array with a saved search' do
          user_saved_search = Cb.saved_search.new.list(@external_user_id, 'WM')
          expect(user_saved_search.models).to be_an_instance_of Array
          expect(user_saved_search.models.first).to be_an_instance_of Cb::Models::SavedSearch
        end
      end

      context 'when the saved search node contains an array' do
        before(:each) { stub_api_to_return({ SavedJobSearches: { SavedSearches: { SavedSearch: [Hash.new, Hash.new] } } }) }

        it 'should return an array of saved searches' do
          user_saved_search = Cb.saved_search.new.list(@external_user_id, 'WM')
          expect(user_saved_search.models).to be_an_instance_of Array
          expect(user_saved_search.models.first).to be_an_instance_of Cb::Models::SavedSearch
        end
      end
    end

    context '.retrieve' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_saved_search_retrieve)).
          to_return(:body => { SavedJobSearch: { Errors: nil, SavedSearch: Hash.new } }.to_json)
      end

      it 'should return a saved search model' do
        response = Cb::Clients::SavedSearch.new.retrieve(@external_user_id, 'xid', @host_site)
        response.model.should be_an_instance_of(Models::SavedSearch)
      end
    end

    context '.delete' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_saved_search_delete)).
          to_return(:body => { Errors: nil, Status: 'Success' }.to_json)
      end

      it 'should delete a saved search without error' do
        model = Models::SavedSearch.new({'ExternalID'=>'xid','ExternalUserID'=>@external_user_id, 'HostSite'=>@host_site})
        Cb.saved_search.new.delete(model)
      end
    end

  end
end
