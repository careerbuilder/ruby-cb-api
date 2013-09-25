require 'spec_helper'

module Cb
  describe Cb::SpotApi do

    describe '#retrieve' do

      before :each do
        @criteria = Cb::SpotRetrieveCriteria.new
        @criteria.maxitems      = 5
        @criteria.language      = 'WMEnglish'
        @criteria.sortdirection = 'Descending'
        @criteria.sortfield     = 'StartDT'
        @criteria.contenttype   = 'ArticleMgt:WMArticles2'
      end

      context 'when everything is working as it should' do
        def assert_correct_models
          @models.should be_a Array
          @models.first.should be_a Cb::Spot
        end

        context 'by interacting with the API client directly' do
          it 'returns an array of Cb::Spot models', :vcr => { :cassette_name => 'spot/retrieve' } do
            @models = Cb::SpotApi.retrieve @criteria
            assert_correct_models
          end
        end

        context 'by calling the API client through the criteria object' do
          it 'return an array of Cb::Spot models', :vcr => { :cassette_name => 'spot/retrieve' } do
            @models = @criteria.retrieve
            assert_correct_models
          end
        end
      end

      context 'when the API response is missing nodes' do
        def restub_mock_api
          api = double(Cb::Utils::Api)
          api.class.stub(:criteria_to_hash)
          api.stub(:cb_get).and_return(@fake_mangled_response)
          Cb::SpotApi.stub(:api_client).and_return(api)
        end

        def expect_fields_missing_exception
          expect {
            Cb::SpotApi.retrieve(@criteria)
          }.to raise_error ExpectedResponseFieldMissing
        end

        context '--> SpotData node <--' do
          before :each do
            @fake_mangled_response = {
              'ResponseRetrieve' => {
                'Errors'           => '',
                'NotTheRightField' => 'Bananas'
              }
            }
            restub_mock_api
          end

          it 'raises an ExpectedResponseFieldMissing exception' do
            expect_fields_missing_exception
          end
        end

        context '--> ResponseRetrieve node <--' do
          before :each do
            @fake_mangled_response = { 'this-hash-is-all' => 'wrong' }
            restub_mock_api
          end

          it 'raises an ExpectedResponseFieldMissing exception' do
            expect_fields_missing_exception
          end
        end
      end

    end

  end
end
