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
