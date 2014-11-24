require 'spec_helper'

module Cb
  describe Responses::State do
    let(:response) { JSON.parse(File.read('spec/support/response_stubs/state.json')) }
    let(:states) { Cb::Responses::State.new(response) }

    context 'when everything works as expected' do
      it { expect(states.models[1].key).to eq('AL') }
    end
  end
end
