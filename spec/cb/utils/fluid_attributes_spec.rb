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
require 'spec_helper'
require 'support/mocks/fluid_attributes_extended'

module Cb
  describe Utils::FluidAttributes do
    let(:fluid_obj) { Mocks::FluidAttributesExtended.new }

    describe 'getters and setters' do
      it 'behaves like attr_accessor' do
        fluid_obj.some_attr = 'some value'
        expect(fluid_obj.some_attr).to eq 'some value'
      end

      it 'returns the attr being set' do
        expect(
          fluid_obj.some_attr = 'some value'
        ).to eq 'some value'
      end
    end

    describe 'method chaining' do
      it 'returns the object having attr set on' do
        expect(fluid_obj.some_attr('some value')).to be fluid_obj
      end

      it 'sets the attr through an unconventional setting method' do
        fluid_obj.some_attr('some value')
        expect(fluid_obj.some_attr).to eq 'some value'
      end

      it 'sets attrs with method chaining' do
        fluid_obj.some_attr('val1').another_attr('val2')

        expect(fluid_obj.some_attr).to eq 'val1'
        expect(fluid_obj.another_attr).to eq 'val2'
      end
    end
  end
end
