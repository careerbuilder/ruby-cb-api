require 'spec_helper'

module Cb
  describe Cb::Clients::AnonSavedSearch do

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
            saved_search = api_calling_code.call
            saved_search.api_error.should eq false
            saved_search.errors.nil?.should eq true
            saved_search.class.should eq Cb::CbSavedSearch
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

      # This test feels unneeded, but I included in anyway since this was a port of previously existing tests. It's
      # testing the functionality of the API itself - one would hope that the API developers have tested this
      # already. The API isn't the unit under test here, the UUT is the API client that we have written. What we
      # should test in this arena is a criteria/request class that prevents this error behavior from coming back
      # from the API.
      context 'when request params are not correct' do
        before :each do
          @args.delete('IsDailyEmail')
          @response_body = { 'Errors' => 'IsDailyEmail is required!' }
          stub_api_request
        end

        it 'missing IsDailyEmail field results in an error in the error collection' do
          saved_search = Cb.anon_saved_search.create @args

          saved_search.api_error.should eq false
          saved_search.errors.nil?.should eq false
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
          response_string = Cb.anon_saved_search.delete @args

          response_string.api_error.should eq false
          response_string.should eq 'Success'
        end
      end
    end # delete

  end
end
