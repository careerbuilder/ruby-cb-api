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

      context 'When a response hash contains a single item' do
        let(:response_hash) {{
            'Hello' => 'world'
        }}
        it 'an array of a single item should be returned' do
          test = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Hello')
          test.class.should == Array
          test.count.should == 1
          test[0].should == 'world'
        end
      end

      context 'When a response hash contains a list of items' do
        let(:response_hash) {{
            'Hello' => 'world,this,is,awesome'
        }}
        it 'an array of items should be returned' do
          test = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Hello')
          test.class.should == Array
          test.count.should == 4
          test[0].should == 'world'
          test[1].should == 'this'
          test[2].should == 'is'
          test[3].should == 'awesome'
        end
      end

      context 'When a response hash contains a single item and not a hash' do
        let(:response_hash) {
          'hello'
        }
        it 'an array of items should be returned' do
          test = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Hello')
          test.class.should == Array
          test.count.should == 0
          test.should == []
        end
      end

    end
  end
end