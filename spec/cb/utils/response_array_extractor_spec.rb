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

    end
  end
end