require 'spec_helper'

module Cb
  module Models
    describe State do
      let(:state) { Models::State.new(state_hash) }

      context 'a state_hash is valid' do
        let(:state_hash) do
          {
              'StateId' => 'AL',
              'StateName' => 'Alabama'
          }
        end
        it { expect(state.key).to eq('AL') }
        it { expect(state.value).to eq ('Alabama') }
      end
    end
  end
end
