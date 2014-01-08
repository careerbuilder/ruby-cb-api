require 'spec_helper'

module Cb::Criteria
  describe Application::Get do
    let(:criteria) {
      Application::Get.new.application_did('ja123')
    }

    describe '#application_did' do
      it 'returns application did' do
        expect(criteria.application_did).to eq 'ja123'
      end
    end

  end
end
