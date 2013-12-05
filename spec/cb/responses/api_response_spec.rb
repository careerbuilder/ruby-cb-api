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
            expect { Responses::ApiResponse.new(Hash.new) }.to raise_error ApiResponseError
          end
        end
      end

      context '#response' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new({:yay => 'yay'}).response }.to raise_error NotImplementedError
        end
      end

      context '#models' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new({:yay => 'yay'}).models }.to raise_error NotImplementedError
        end
      end

      context '#[]' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new({:yay => 'yay'})[:yay] }.to raise_error NotImplementedError
        end
      end

      context '#timing' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new({:yay => 'yay'}).timing }.to raise_error NotImplementedError
        end
      end

      context '#errors' do
        it 'raises a NotImplementedError' do
          expect { Responses::ApiResponse.new({:yay => 'yay'}).errors }.to raise_error NotImplementedError
        end
      end
    end

    context 'when minimally overriden' do

      class BrokenDirtyResponse1 < Responses::ApiResponse
        def metadata_containing_node
          response
        end
      end

      class BrokenDirtyResponse2 < BrokenDirtyResponse1
        def validate_api_hash
          required_response_field(:stuff, response)
        end
      end

      class DumbValidResponse < BrokenDirtyResponse2
        def extract_models
          response[:stuff].map { |doodad| doodad }
        end
      end

      context '#new' do
        context 'when the input hash has all fields and all methods override' do

          let(:input_hash) { {:stuff => [{ :huzzah => :thangs }]} }

          it 'instantiates happily' do
            DumbValidResponse.new(input_hash)
          end

          context 'but is missing method implementations' do
            context '--> metadata_containing_node <--' do
              it 'raises an error' do
                begin
                  Responses::ApiResponse.new(input_hash)
                rescue NotImplementedError => err
                  err.message.include?('metadata_containing_node')
                end
              end
            end

            context '--> validate_api_hash <--' do
              it 'raises an error' do
                begin
                  BrokenDirtyResponse1.new(input_hash)
                rescue NotImplementedError => err
                  err.message.include?('validate_api_hash')
                end
              end
            end

            context '--> extract_models <--' do
              it 'raises an error' do
                begin
                  BrokenDirtyResponse2.new(input_hash)
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
end
