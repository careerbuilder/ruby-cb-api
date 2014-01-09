require 'spec_helper'

module Cb
  describe Clients::Application do
    before {
      Cb.configuration.dev_key = 'mydevkey'
      Cb.configuration.host_site = 'US'
    }
    let(:client) { Clients::Application }
    let(:response_stub) { YAML.load open('spec/support/response_stubs/application.yml') }

    describe '#get' do
      before {
        Cb::Utils::Api.any_instance.stub(:cb_get).and_return(response_stub)
      }
      let(:criteria) { Criteria::Application::Get.new.application_did('app_did') }

      it 'returns an application response' do
        expect(
          client.get(criteria)
        ).to be_a Responses::Application
      end

      it 'sends #cb_get to api_client a uri with the application_did' do
        expected_uri = "/cbapi/application/#{criteria.application_did}"
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
      let(:criteria) { Criteria::Application::Create.new.resume(resume).cover_letter(cover_letter).responses(responses).job_did('j123') }
      let(:resume) { Criteria::Application::Resume.new }
      let(:cover_letter) { Criteria::Application::CoverLetter.new }
      let(:responses) { [Criteria::Application::Response.new] }

      it 'returns an application response' do
        expect(
          client.create(criteria)
        ).to be_a Responses::Application
      end

      it 'sends #cb_post to api_client a uri with the job_did' do
        expected_uri = "/cbapi/application/#{criteria.job_did}"
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

    describe '#update' do
      before {
        Cb::Utils::Api.any_instance.stub(:cb_put).and_return(response_stub)
      }
      let(:criteria) {
        Criteria::Application::Update.new.resume(resume).cover_letter(cover_letter).responses(responses)
          .application_did('app_did').job_did('job_did')
      }
      let(:resume) { Criteria::Application::Resume.new }
      let(:cover_letter) { Criteria::Application::CoverLetter.new }
      let(:responses) { [Criteria::Application::Response.new] }

      it 'returns an application response' do
        expect(
          client.update(criteria)
        ).to be_a Responses::Application
      end

      it 'sends #cb_put to api_client a uri with the job_did' do
        expected_uri = "/cbapi/application/#{criteria.job_did}"
        Cb::Utils::Api.any_instance.should_receive(:cb_put).with(expected_uri, anything)

        client.update(criteria)
      end

      it 'sends #cb_put to api_client headers with the developer_key' do
        Cb::Utils::Api.any_instance.should_receive(:cb_put).with do |uri, hash|
          hash[:headers]['DeveloperKey'] == 'mydevkey'
        end

        client.update(criteria)
      end

      it 'sends #cb_put to api_client headers with the host_site' do
        Cb::Utils::Api.any_instance.should_receive(:cb_put).with do |uri, hash|
          hash[:headers]['HostSite'] == 'US'
        end

        client.update(criteria)
      end

    end

  end
end
