require 'spec_helper'

module Cb
  describe Cb::Clients::AnonSavedSearch.new do

    before :each do
      @args = {
        'EmailAddress' => 'test@test.com',
        'BrowserId'    => '123abc',
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
        stub_request(:post, uri_stem(Cb.configuration.uri_anon_saved_search_create)).
          with(:body => anything).
          to_return(:body => @response_body.to_json)
      end

      context 'when everything is working smoothly' do
        context 'should successfully create a new anonymous saved search via:' do
          def assert_no_error_on_model(&api_calling_code)
            saved_search_response = api_calling_code.call
            saved_search_response.class.should eq Responses::AnonymousSavedSearch::Create
            model_class = saved_search_response.model.class
            model_class.should eq Models::SavedSearch
          end

          before :each do
            @response_body = { 'Errors' => '', 'ExternalID' => 'eid', 'AnonymousSavedSearch' => { 'things' => 'stuff' } }
            stub_api_request
          end

          it 'the Cb module convenience method' do
            assert_no_error_on_model { Cb.anon_saved_search.new.create @args }
          end

          it 'the anonymous saved search api client directly' do
            assert_no_error_on_model { Cb::Clients::AnonSavedSearch.new.create @args }
          end
        end
      end
    end # create

    context '#delete' do
      context 'when everything is working smoothly' do
        def stub_api_request
          stub_request(:post, uri_stem(Cb.configuration.uri_anon_saved_search_delete.to_s)).
            with(:body => anything).
            to_return(:body => { 'Errors' => '', 'Status' => 'Success' }.to_json)
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
          response = Cb.anon_saved_search.new.delete @args
          response.model.status.should eq 'Success'
        end
      end
    end # delete

  end
end
