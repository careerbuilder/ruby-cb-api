require 'spec_helper'

module Cb
  module Models
    describe State do
      let(:state) { Models::State.new(state_hash) }
      let(:state_hash) { JSON.parse(File.read('spec/support/response_stubs/state.json')) }

      context 'a state_hash is valid' do
        let(:state_hash) do
          {
              'StateId' => 'AL',
              'StateName' => 'Alabama'
          }
        end
        it { expect(state.key).to eq('AL') }
      end
    end
  end
end
