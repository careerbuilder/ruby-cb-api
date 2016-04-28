require 'spec_helper'
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
module Cb
  describe Responses::ApiResponse do
    # This is meant to be an abstract class providing template methods for
    # subclasses to override. You probably won't be instantiating any of this
    # class - notice how many errors these specs look for.

    context 'when instantiated directly' do
      context '#new' do
        context 'when called without an input hash' do
          it 'raises an error' do
            expect { Responses::ApiResponse.new(nil) }.to raise_error ApiResponseError
          end
        end

        context 'when called with an empty input hash' do
          it 'raises an error' do
            expect { Responses::ApiResponse.new({}) }.to raise_error ApiResponseError
          end
        end
      end

      context '#response' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new(yay: 'yay').response }.to raise_error NotImplementedError
        end
      end

      context '#models' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new(yay: 'yay').models }.to raise_error NotImplementedError
        end
      end

      context '#[]' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new(yay: 'yay')[:yay] }.to raise_error NotImplementedError
        end
      end

      context '#timing' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new(yay: 'yay').timing }.to raise_error NotImplementedError
        end
      end

      context '#errors' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new(yay: 'yay').errors }.to raise_error NotImplementedError
        end
      end
    end

    context 'when minimally overriden' do
      class BrokenDirtyResponse1 < Responses::ApiResponse
        def hash_containing_metadata
          response['ResponseStuff']
        end
      end

      class BrokenDirtyResponse2 < BrokenDirtyResponse1
        def validate_api_hash
          required_response_field('stuff', response['ResponseStuff'])
        end
      end

      class DumbValidResponse < BrokenDirtyResponse2
        def extract_models
          response['ResponseStuff']['stuff'].map { |doodad| doodad }
        end
      end

      let(:model_hashes) { [{ 'huzzah' => 'thangs' }] }
      let(:valid_input_hash) { { 'ResponseStuff' => { 'stuff' => model_hashes } } }
      let(:other_input_hash) { { 'ResponseStuff' => { 'other_stuff' => model_hashes } } }



      context 'when the input hash has all fields and all methods overridden' do
        it '#new instantiates happily' do
          DumbValidResponse.new(valid_input_hash)
        end

        context '#models' do
          it 'returns whatever is returned from the overriden #extract_models method' do
            expect(DumbValidResponse.new(valid_input_hash).models).to eq model_hashes
          end
        end

        # #model exists just in case you want to call a method that makes sense to get only a single model (some APIs return only 1 of something)
        context '#model' do
          it 'returns whatever is returned from the overriden #extract_models method' do
            expect(DumbValidResponse.new(valid_input_hash).model).to eq model_hashes
          end
        end

        context '#timing' do
          it 'returns a timing object that responds to #elapsed' do
            expect(DumbValidResponse.new(valid_input_hash).timing.respond_to?(:elapsed)).to eq true
          end

          it 'returns a timing object that responds to #response_sent' do
            expect(DumbValidResponse.new(valid_input_hash).timing.respond_to?(:response_sent)).to eq true
          end
        end

        context '#errors' do
          # #errors delegates to a different object with its own suite of tests
          it 'returns an errors object' do
            expect(DumbValidResponse.new(valid_input_hash).respond_to?(:errors)).to eq true
          end
        end
      end

      context 'Missing Required Field' do
        it 'throws ExpectedResponseFieldMissing with specific error message' do
          expect{ DumbValidResponse.new(other_input_hash) }.to raise_error(Cb::ExpectedResponseFieldMissing) do |ex|
            expect(ex.message).to eq "Response field missing 'stuff' for Cb::DumbValidResponse"
          end
        end
      end

      context '#new' do
        context 'when hash_containing_metadata returns nil' do
          class ResponseWithoutMetadataParsing < Responses::ApiResponse
            def hash_containing_metadata
              nil
            end

            # these methods have to be overriden or else we get NotImplemented errors
            def validate_api_hash; end

            def extract_models; end
          end

          it 'metadata parsing does not occur' do
            expect(Responses::Metadata).not_to receive(:new)
            ResponseWithoutMetadataParsing.new(valid_input_hash)
          end
        end

        context 'but is missing method implementations' do
          context '--> hash_containing_metadata <--' do
            it 'raises an error' do
              begin
                Responses::ApiResponse.new(valid_input_hash)
              rescue NotImplementedError => err
                err.message.include?('hash_containing_metadata')
              end
            end
          end

          context '--> validate_api_hash <--' do
            it 'raises an error' do
              begin
                BrokenDirtyResponse1.new(valid_input_hash)
              rescue NotImplementedError => err
                err.message.include?('validate_api_hash')
              end
            end
          end

          context '--> extract_models <--' do
            it 'raises an error' do
              begin
                BrokenDirtyResponse2.new(valid_input_hash)
              rescue NotImplementedError => err
                err.message.include?('extract_models')
              end
            end
          end
        end
      end
    end
  end
end
