require 'spec_helper'

module Cb
  describe Clients::ApplicationV2 do
    describe '#get' do
      context 'When given a criteria object' do
        let(:criteria) { Criteria::Application::Get.new.application_did('my_application_did') }
        let(:client) { Clients::ApplicationV2 }

        it 'returns an application response' do
          expect(client.get(criteria)).to be_a Responses::Application::Get
        end

      end
    end
  end
end
