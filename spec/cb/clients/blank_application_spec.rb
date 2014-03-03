require './spec/spec_helper'

module Cb
	describe Clients::BlankApplication do
		let(:client) { Cb::Clients::BlankApplication.new }
		let(:response_stub) { YAML.load open('spec/support/response_stubs/blank_application.yml') }

		describe '#get' do
			before {
				Cb::Utils::Api.any_instance.stub(:cb_get).and_return(response_stub)
				Cb.configuration.dev_key = 'test_dev_key'
			}

			let(:criteria) { {:JobDID => 'J8A2RM68F1DL4WZ25LJ'} }
			let(:response) { client.get(criteria) }
			let(:uri) { '/v1/application/blank' }

			it 'returns a blank_application response' do
				expect(response).to be_a(Models::BlankApplication)
			end

			it "should return the correct job_did's response" do
				expect(response.job_did).to eq(criteria[:JobDID])
			end

			it 'sends #cb_get to api_client' do
				Cb::Utils::Api.any_instance.should_receive(:cb_get).with(uri, anything)
				client.get(criteria)
			end

			it 'sends #cb_get to api_client headers with dev key' do
				Cb::Utils::Api.any_instance.should_receive(:cb_get).with do |uri, hash|
					hash[:headers][:DeveloperKey] == 'test_dev_key'
				end

				client.get(criteria)
			end

			it 'sends #cb_get to api_client headers with job_did' do
				Cb::Utils::Api.any_instance.should_receive(:cb_get).with do |uri, hash|
					hash[:headers][:JobDID] == criteria[:JobDID]
				end

				client.get(criteria)
			end

		end

	end
end