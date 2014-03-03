require './spec/spec_helper'

module Cb
	describe Clients::BlankApplication do
		let(:client) { Cb::Clients::BlankApplication.new }
		let(:response_stub) { YAML.load open('spec/support/response_stubs/blank_application.yml') }

		describe '#get' do
			before { Cb::Utils::Api.any_instance.stub(:cb_get).and_return(response_stub) }

			let(:criteria) { {:JobDID => 'J8A2RM68F1DL4WZ25LJ'} }
			let(:response_object) { client.get(criteria) }

			it 'returns a blank_application response' do
				expect(response_object).to be_a(Responses::BlankApplication)
			end

			it "should return the correct job_did's response" do
				p response_object
			end

		end

	end
end