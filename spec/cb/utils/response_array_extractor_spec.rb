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
          animals.class.should == Array
          animals.count.should == 1
          animals[0].should == 'Moose'
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
          animals.class.should == Array
          animals.count.should == 2
          animals[0].should == 'Moose'
          animals[1].should == 'Kitty'
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
          matches.class.should == Array
          matches.count.should == 2
          matches[0].should == 'FUN!'
          matches[1].should == 'Excite!'
        end
      end

    end
  end
end