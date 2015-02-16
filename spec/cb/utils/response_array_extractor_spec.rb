require 'spec_helper'

module Cb
  module Utils
    describe ResponseArrayExtractor do

      context 'When a response hash contains a collection that only has one item' do
        let(:response_hash) {{
          'Animals' => {
            'Animal' => 'Moose'
          }
        }}

        it 'an array with the single item should be returned' do
          animals = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Animals')
          expect(animals.class).to eq(Array)
          expect(animals.count).to eq(1)
          expect(animals[0]).to eq('Moose')
        end
      end

      context 'When a response hash contains a collection that hash multiple items' do
        let(:response_hash) {{ 
          'Animals' => { 
            'Animal' => ['Moose', 'Kitty'] 
          } 
        }}

        it 'an array with multiple items should be returned' do
          animals = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Animals')
          expect(animals.class).to eq(Array)
          expect(animals.count).to eq(2)
          expect(animals[0]).to eq('Moose')
          expect(animals[1]).to eq('Kitty')
        end 
      end

      context 'When an optional singular key is provided' do
        let(:response_hash) do
          {
            'Matches' => {
              'Match' => ['FUN!', 'Excite!']
            }
          }
        end

        it 'is still able to parse' do
          matches = ResponseArrayExtractor.extract(response_hash, 'Matches', 'Match')
          expect(matches.class).to eq(Array)
          expect(matches.count).to eq(2)
          expect(matches[0]).to eq('FUN!')
          expect(matches[1]).to eq('Excite!')
        end
      end

      context 'When a response hash contains a single item' do
        let(:response_hash) {{
            'Hello' => 'world'
        }}
        it 'an array of a single item should be returned' do
          test = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Hello')
          expect(test.class).to eq(Array)
          expect(test.count).to eq(1)
          expect(test[0]).to eq('world')
        end
      end

      context 'When a response hash contains a list of items' do
        let(:response_hash) {{
            'Hello' => 'world,this,is,awesome'
        }}
        it 'an array of items should be returned' do
          test = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Hello')
          expect(test.class).to eq(Array)
          expect(test.count).to eq(4)
          expect(test[0]).to eq('world')
          expect(test[1]).to eq('this')
          expect(test[2]).to eq('is')
          expect(test[3]).to eq('awesome')
        end
      end

      context 'When a response hash contains a single item and not a hash' do
        let(:response_hash) {
          'hello'
        }
        it 'an array of items should be returned' do
          test = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Hello')
          expect(test.class).to eq(Array)
          expect(test.count).to eq(0)
          expect(test).to eq([])
        end
      end

    end
  end
end