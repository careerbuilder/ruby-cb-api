require 'spec_helper'

module Cb
  describe Clients::Application do
    describe '#get' do
      before {
        Cb::Utils::Api.any_instance.stub(:cb_get).and_return(response_stub)
        Cb.configuration.dev_key = 'mydevkey'
        Cb.configuration.host_site = 'US'
      }
      let(:response_stub) { YAML.load open('spec/support/response_stubs/application/get.yml') }
      let(:criteria) { Criteria::Application::Get.new.did('app_did') }
      let(:client) { Clients::Application }

      it 'returns an application response' do
        expect(
          client.get(criteria)
        ).to be_a Responses::Application::Get
      end

      it 'sends #cb_get to api_client a uri with the application_did' do
        expected_uri = "/cbapi/application/#{criteria.did}"
        Cb::Utils::Api.any_instance.should_receive(:cb_get).with(expected_uri, anything)

        client.get(criteria)
      end

      it 'sends #cb_get to api_client headers with the developer_key' do
        Cb::Utils::Api.any_instance.should_receive(:cb_get).with do |uri, hash|
          hash[:headers]['DeveloperKey'] == 'mydevkey'
        end

        client.get(criteria)
      end

      it 'sends #cb_get to api_client headers with the host_site' do
        Cb::Utils::Api.any_instance.should_receive(:cb_get).with do |uri, hash|
          hash[:headers]['HostSite'] == 'US'
        end

        client.get(criteria)
      end

    end
  end
end
