require 'spec_helper'

module Cb
  describe Cb::ApiClients::Spot do

    it 'caches the Cb::Utils::Api client for subsecuent calls' do
      # using Object#send since #api_client is a private method
      api_client          = ApiClients::Spot.send(:api_client)
      the_same_api_client = ApiClients::Spot.send(:api_client)

      api_client.should eq the_same_api_client
      api_client.object_id.should eq the_same_api_client.object_id
    end

    describe '#retrieve' do

      before :each do
        @criteria = Criteria::SpotRetrieve.new
        @criteria.maxitems      = 5
        @criteria.language      = 'WMEnglish'
        @criteria.sortdirection = 'Descending'
        @criteria.sortfield     = 'StartDT'
        @criteria.contenttype   = 'ArticleMgt:WMArticles2'
      end

      context 'when everything is working as it should' do
        def assert_correct_models
          @models.should be_a Array
          @models.first.should be_a Models::Spot
        end

        context 'by interacting with the API client directly' do
          it 'returns an array of Cb::Spot models', :vcr => { :cassette_name => 'spot/retrieve' } do
            @models = ApiClients::Spot.retrieve @criteria
            assert_correct_models
          end
        end

        context 'by calling the API client through the criteria object' do
          it 'returns an array of Cb::Spot models', :vcr => { :cassette_name => 'spot/retrieve' } do
            @models = @criteria.retrieve
            assert_correct_models
          end
        end

        context 'by calling the API client from the Cb module convenience method' do
          it 'returns an array of Cb::Spot models', :vcr => { :cassette_name => 'spot/retrieve' } do
            @models = Cb.spot.retrieve @criteria
            assert_correct_models
          end
        end
      end

      context 'when the API response is missing nodes' do
        def restub_mocked_api
          api = Cb::Utils::Api.new
          api.class.stub(:criteria_to_hash)
          api.stub(:cb_get).and_return(@fake_mangled_response)
          ApiClients::Spot.stub(:api_client).and_return(api)
        end

        def expect_fields_missing_exception
          expect {
            ApiClients::Spot.retrieve(@criteria)
          }.to raise_error ExpectedResponseFieldMissing
        end

        context '--> SpotData node <--' do
          before :each do
            @fake_mangled_response = { 'ResponseRetrieve' => { 'NotTheRightField' => 'Bananas' } }
            restub_mocked_api
          end

          it 'raises an ExpectedResponseFieldMissing exception' do
            expect_fields_missing_exception
          end
        end

        context '--> ResponseRetrieve node <--' do
          before :each do
            @fake_mangled_response = { 'this-hash-is-all' => 'wrong' }
            restub_mocked_api
          end

          it 'raises an ExpectedResponseFieldMissing exception' do
            expect_fields_missing_exception
          end
        end
      end

    end

  end
end
