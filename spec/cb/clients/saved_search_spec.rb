# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'spec_helper'
require 'support/mocks/saved_search'

module Cb
  describe Cb::Clients::SavedSearch do
    context '.new' do
      it 'should create a new saved job search api object' do
        saved_search_request = Cb::Clients::SavedSearch.new
        expect(saved_search_request).to be_a_kind_of(Cb::Clients::SavedSearch)
      end
    end

    context '.create' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_saved_search_create))
          .with(body: anything)
          .to_return(body: { SavedJobSearch: { Errors: nil, SavedSearch: {} } }.to_json)
      end

      it 'should return a saved search retrieve response' do
        email_frequency = 'None'
        search_name = 'Fake Job Search 1'
        model = Models::SavedSearch.new('DeveloperKey' => Cb.configuration.dev_key, 'IsDailyEmail' => email_frequency,
                                        'ExternalUserID' => @external_user_id, 'SearchName' => search_name,
                                        'HostSite' => @host_site)

        expect(Cb.saved_search.new.create(model).class).to eq Responses::SavedSearch::Singular
      end
    end

    context '.update' do
      context 'with host_site passed in the request header' do
        before do
          stub_request(:put, uri_stem(Cb.configuration.uri_saved_search_update))
            .with(body: anything,
                  headers: { 'developerkey' => Cb.configuration.dev_key, 'Content-Type' => 'application/json', 'HostSite' => 'GR' })
            .to_return(body: { Errors: nil, Results: [{ SavedSearchParameters: {} }] }.to_json)
        end

        it 'should update the saved search created in this test' do
          external_id = 'DID'
          oauth = '123412341234'
          email_frequency = 'None'
          search_name = 'Fake Job Search Update'
          model = Models::SavedSearch.new('IsDailyEmail' => email_frequency,
                                          'DID' => external_id, 'SearchName' => search_name,
                                          'HostSite' => 'GR', 'userOAuthToken' => oauth)

          response = Cb.saved_search.new.update(model)
          expect(response.model.class).to eq Models::SavedSearch
        end
      end

      context 'with no host_site passed in the request header' do
        before do
          stub_request(:put, uri_stem(Cb.configuration.uri_saved_search_update))
            .with(body: anything,
                  headers: { 'developerkey' => Cb.configuration.dev_key, 'Content-Type' => 'application/json', 'HostSite' => 'US' })
            .to_return(body: { Errors: nil, Results: [{ SavedSearchParameters: {} }] }.to_json)
        end

        it 'should update the saved search created in this test' do
          external_id = 'DID'
          oauth = '123412341234'
          email_frequency = 'None'
          search_name = 'update_headers(saved_search.host_site)Fake Job Search Update'
          model = Models::SavedSearch.new('IsDailyEmail' => email_frequency,
                                          'DID' => external_id, 'SearchName' => search_name,
                                          'HostSite' => nil, 'userOAuthToken' => oauth)

          response = Cb.saved_search.new.update(model)
          expect(response.model.class).to eq Models::SavedSearch
        end
      end
    end

    context '.list' do
      context 'with results' do
        before do
          stub_request(:get, uri_stem(Cb.configuration.uri_saved_search_list))
            .to_return(body: Mocks::SavedSearch.list.to_json)
        end

        it 'should return an array of saved searches' do
          user_saved_search = Cb.saved_search.new.list(@user_oauth_token, 'WR')
          expect(user_saved_search.models).to be_an_instance_of Array
          expect(user_saved_search.models.count).to eq(2)
          expect(user_saved_search.models.first).to be_an_instance_of Cb::Models::SavedSearch
        end
      end

      context 'with no results' do
        before do
          stub_request(:get, uri_stem(Cb.configuration.uri_saved_search_list))
            .to_return(body: Mocks::SavedSearch.empty_list.to_json)
        end

        it 'should return an array of saved searches' do
          user_saved_search = Cb.saved_search.new.list(@user_oauth_token, 'WR')
          expect(user_saved_search.models).to be_an_instance_of Array
          expect(user_saved_search.models.count).to eq(0)
        end
      end
    end

    context '.retrieve' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_saved_search_retrieve.gsub(':did', 'xid')))
          .to_return(body: {
            'TotalResults' => 1,
            'ReturnedResults' => 1,
            'Results' =>             [{ 'DID' => 'OMG DIDs',
                                        'SearchName' => "Why can't I find a jerb?",
                                        'HostSite' => 'Merkah',
                                        'SiteID' => '',
                                        'Cobrand' => '',
                                        'IsDailyEmail' => 'maybe',
                                        'EmailDeliveryDay' => 'YESTERDAY',
                                        'JobSearchUrl' => 'blerg.com',
                                        'SavedSearchParameters' => {
                                          'Any' => 'No' }
             }],
            'Errors' => [],
            'Timestamp' => '2014-03-25T15:29:27.8361791-04:00',
            'Status' => 'YEY' }.to_json)
      end

      it 'should return a saved search model' do
        response = Cb::Clients::SavedSearch.new.retrieve(@user_oauth_token, 'xid')
        expect(response.model).to be_an_instance_of(Models::SavedSearch)
      end
    end

    context '.delete' do
      before :each do
        stub_request(:delete, 'https://api.careerbuilder.com/cbapi/savedsearches/xid?UserOAuthToken=oauth&developerkey=mydevkey&outputjson=true')
          .with(headers: { 'Accept-Encoding' => 'deflate, gzip', 'Developerkey' => 'mydevkey', 'Hostsite' => 'host site' })
          .to_return(body: { Errors: nil, Status: 'Success' }.to_json)
      end

      it 'should delete a saved search without error' do
        hash = { did: 'xid', user_oauth_token: 'oauth', host_site: 'host site' }
        Cb.saved_search.new.delete(hash)
      end
    end
  end
end
