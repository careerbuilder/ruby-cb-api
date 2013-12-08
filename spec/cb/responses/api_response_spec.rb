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

      let(:model_hashes) { [{ 'huzzah' => 'thangs'}] }
      let(:valid_input_hash) { { 'ResponseStuff' => { 'stuff' => model_hashes} } }
      let(:errored_input_hash) { { 'ResponseStuff' => { 'errors' => { 'error' => ['oh noes!', 'bah!']}, :stuff => model_hashes } } }

      context 'when the input hash has all fields and all methods overridden' do
        it '#new instantiates happily' do
          DumbValidResponse.new(valid_input_hash)
        end

        context '#models' do
          it 'returns whatever is returned from the overriden #extract_models method' do
            DumbValidResponse.new(valid_input_hash).models.should eq model_hashes
          end
        end

        context '#timing' do
          it 'returns a timing object that responds to #elapsed' do
            DumbValidResponse.new(valid_input_hash).timing.respond_to?(:elapsed).should eq true
          end

          it 'returns a timing object that responds to #response_sent' do
            DumbValidResponse.new(valid_input_hash).timing.respond_to?(:response_sent).should eq true
          end
        end

        context '#errors' do
          # #errors delegates to a different object with its own suite of tests
          it 'returns an errors object' do
            DumbValidResponse.new(valid_input_hash).respond_to?(:errors).should eq true
          end
        end
      end

      context '#new' do
        context 'but is missing method implementations' do
          context '--> metadata_containing_node <--' do
            it 'raises an error' do
              begin
                Responses::ApiResponse.new(valid_input_hash)
              rescue NotImplementedError => err
                err.message.include?('metadata_containing_node')
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
