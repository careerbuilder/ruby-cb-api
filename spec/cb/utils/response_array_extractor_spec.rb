# Copyright 2016 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'spec_helper'

module Cb
  module Utils
    describe ResponseArrayExtractor do
      context 'When a response hash contains a collection that only has one item' do
        let(:response_hash) do
          {
            'Animals' => {
              'Animal' => 'Moose'
            }
          }
        end

        it 'an array with the single item should be returned' do
          animals = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Animals')
          expect(animals.class).to eq(Array)
          expect(animals.count).to eq(1)
          expect(animals[0]).to eq('Moose')
        end
      end

      context 'When a response hash contains a collection that hash multiple items' do
        let(:response_hash) do
          {
            'Animals' => {
              'Animal' => %w(Moose Kitty)
            }
          }
        end

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
        let(:response_hash) do
          {
            'Hello' => 'world'
          }
        end
        it 'an array of a single item should be returned' do
          test = Cb::Utils::ResponseArrayExtractor.extract(response_hash, 'Hello')
          expect(test.class).to eq(Array)
          expect(test.count).to eq(1)
          expect(test[0]).to eq('world')
        end
      end

      context 'When a response hash contains a list of items' do
        let(:response_hash) do
          {
            'Hello' => 'world,this,is,awesome'
          }
        end
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
        let(:response_hash) do
          'hello'
        end
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
