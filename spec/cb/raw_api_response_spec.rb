require 'spec_helper'

module Cb
  # this class is meant to be inherited, not directly instantiated! therefore behavior
  # is demonstrated below using dummy implementations.
  describe Cb::Responses::RawApiResponse do

    describe '#new' do

      context 'when the inheriting class overrides the required methods' do

        class ValidDummyRawResponse < Cb::Responses::RawApiResponse
          def validate_raw_api_response
            required_response_field 'bananas', raw_api_hash
          end

          def extract_models
            raw_api_hash['bananas']
          end
        end

        before :each do
          @hash = { 'bananas' => 'b-a-n-a-n-a-s' }
          @response = ValidDummyRawResponse.new(@hash)
        end

        it 'the raw API hash is accessible via the #raw_api_hash method' do
          @response.send(:raw_api_hash).should eq @hash
        end

        context 'and the underlying API hash has all of the required fields' do
          it '#extract_models throws no error since everything is hunky dory' do
            @response.extract_models.should eq 'b-a-n-a-n-a-s'
          end
        end

        context 'but #require_response_field is used in funky ways' do
          it 'argument 1 of 2 cannot be nil' do
            expect {
              @response.send(:required_response_field, nil, @hash)
            }.to raise_error ArgumentError
          end

          it 'argument 2 of 2 cannot be nil' do
            expect {
              @response.send(:required_response_field, 'bananas', nil)
            }.to raise_error ArgumentError
          end
        end

        context 'but the underlying hash does not have the correct fields' do
          before :each do
            @hash = { 'oranges' => 'uh ohes' }
          end

          it '#new raises ExpectedResponseFieldMissing upon initialization' do
            expect { ValidDummyRawResponse.new(@hash) }.to raise_error ExpectedResponseFieldMissing
          end
        end

      end

      context 'when directly instantiating the base class' do
        it 'raises NotImplementedError upon initialization' do
          expect { Responses::RawApiResponse.new }.to raise_error NotImplementedError
        end
      end

    end # new

  end
end
