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

module Cb
  describe Cb::Clients::AnonSavedSearch do
    before :each do
      @args = {
        'EmailAddress' => 'test@test.com',
        'BrowserID'    => '123abc',
        'SessionID'    => 'abs123',
        'HostSite'     => 'WR',
        'DeveloperKey' => 'HOORAY!',
        'SearchName'   => 'fajitas',
        'Keywords'     => 'tortillas, steak, onions, peppers',
        'Location'     => 'atlanta',
        'IsDailyEmail' => 'none',
        'Test'         => 'false'
      }
    end

    context '#create' do
      def stub_api_request
        stub_request(:post, uri_stem(Cb.configuration.uri_anon_saved_search_create))
          .with(body: anything)
          .to_return(body: @response_body.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
      end

      context 'when everything is working smoothly' do
        context 'should successfully create a new anonymous saved search via:' do
          def assert_no_error_on_model(&api_calling_code)
            saved_search_response = api_calling_code.call
            expect(saved_search_response.class).to eq Responses::AnonymousSavedSearch::Create
            model_class = saved_search_response.model.class
            expect(model_class).to eq Models::SavedSearch
          end

          before :each do
            @response_body = { 'Errors' => '', 'ExternalID' => 'eid', 'AnonymousSavedSearch' => { 'things' => 'stuff' } }
            stub_api_request
          end

          it 'the Cb module convenience method' do
            assert_no_error_on_model { Cb.anon_saved_search.create @args }
          end

          it 'the anonymous saved search api client directly' do
            assert_no_error_on_model { Cb::Clients::AnonSavedSearch.create @args }
          end
        end
      end
    end # create

    context '#delete' do
      context 'when everything is working smoothly' do
        def stub_api_request
          stub_request(:post, uri_stem(Cb.configuration.uri_anon_saved_search_delete.to_s))
            .with(body: anything)
            .to_return(body: { 'Errors' => '', 'Status' => 'Success' }.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
        end

        before :each do
          @args = {
            'ExternalID'   => 'yay',
            'Test'         => false,
            'DeveloperKey' => 'whoa'
          }
          stub_api_request
        end

        it 'should successfully delete an anonymous saved search' do
          response = Cb.anon_saved_search.delete @args
          expect(response.model.status).to eq 'Success'
        end
      end
    end # delete
  end
end
