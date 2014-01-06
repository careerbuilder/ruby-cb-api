require 'spec_helper'

module Cb
  describe Clients::Application do
    before {
      Cb.configuration.dev_key = 'mydevkey'
      Cb.configuration.host_site = 'US'
    }
    let(:client) { Clients::Application }
    let(:response_stub) { YAML.load open('spec/support/response_stubs/application/get.yml') }

    describe '#get' do
      before {
        Cb::Utils::Api.any_instance.stub(:cb_get).and_return(response_stub)
      }
      let(:criteria) { Criteria::Application.new.did('app_did') }

      it 'returns an application response' do
        expect(
          client.get(criteria)
        ).to be_a Responses::Application
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

    describe '#create' do
      before {
        Cb::Utils::Api.any_instance.stub(:cb_post).and_return(response_stub)
      }
      let(:criteria) { Criteria::Application.new.resume(resume).cover_letter(cover_letter).responses(responses) }
      let(:resume) { Criteria::Application::Resume.new }
      let(:cover_letter) { Criteria::Application::CoverLetter.new }
      let(:responses) { [Criteria::Application::Response.new] }

      it 'returns an application response' do
        expect(
          client.create(criteria)
        ).to be_a Responses::Application
      end

      it 'sends #cb_post to api_client a uri with the application_did' do
        expected_uri = "/cbapi/application/"
        Cb::Utils::Api.any_instance.should_receive(:cb_post).with(expected_uri, anything)

        client.create(criteria)
      end

      it 'sends #cb_post to api_client headers with the developer_key' do
        Cb::Utils::Api.any_instance.should_receive(:cb_post).with do |uri, hash|
          hash[:headers]['DeveloperKey'] == 'mydevkey'
        end

        client.create(criteria)
      end

      it 'sends #cb_post to api_client headers with the host_site' do
        Cb::Utils::Api.any_instance.should_receive(:cb_post).with do |uri, hash|
          hash[:headers]['HostSite'] == 'US'
        end

        client.create(criteria)
      end
    end

  end
end
