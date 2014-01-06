require 'spec_helper'

module Cb
  describe Clients::Application do
    describe '#get' do
      context 'When given a criteria object' do
        let(:criteria) { Criteria::Application::Get.new.application_did('my_application_did') }
        let(:client) { Clients::Application }

        it 'returns an application response' do
          expect(client.get(criteria)).to be_a Responses::Application::Get
        end

      end
    end
  end
end
