require 'spec_helper'

module Cb
  describe Clients::Application do
    shared_examples 'it passes the correct headers' do
      before { allow(response_class).to receive(:new).and_return('mock response') }

      let(:expected_headers) do
        {
          'DeveloperKey' => Cb.configuration.dev_key,
          'HostSite' => Cb.configuration.host_site,
          'Content-Type' => 'application/json'
        }
      end

      it 'passes the correct headers in the options hash' do
        expect_any_instance_of(Cb::Utils::Api).to receive(http_calling_method) do |_, _, options_hash|
          expect(options_hash[:headers]).to eq expected_headers
        end
        subject
      end
    end

    before do
      Cb.configuration.dev_key = 'mydevkey'
      Cb.configuration.host_site = 'US'
    end

    let(:client) { Clients::Application }
    let(:response_stub) { YAML.load open('spec/support/response_stubs/application.yml') }
    let(:response_class) { Responses::Application }

    describe '#get' do
      subject { client.get(criteria) }

      before do
        allow_any_instance_of(Cb::Utils::Api).to receive(:cb_get).and_return(response_stub)
      end

      let(:criteria) { Criteria::Application::Get.new.application_did('app_did') }
      let(:http_calling_method) { :cb_get }

      it 'returns an application response' do
        expect(subject).to be_an response_class
      end

      it 'sends #cb_get to api_client a uri with the application_did' do
        expected_uri = "/cbapi/application/#{criteria.application_did}"
        expect_any_instance_of(Cb::Utils::Api).to receive(http_calling_method).with(expected_uri, anything)
        subject
      end

      it_behaves_like 'it passes the correct headers'
    end

    describe '#create' do
      subject { client.create(criteria) }

      before { allow_any_instance_of(Cb::Utils::Api).to receive(:cb_post).and_return(response_stub) }
      let(:criteria) { Criteria::Application::Create.new.resume(resume).cover_letter(cover_letter).responses(responses).host_site(host_site) }
      let(:host_site) { nil }
      let(:resume) { Criteria::Application::Resume.new }
      let(:cover_letter) { Criteria::Application::CoverLetter.new }
      let(:responses) { [Criteria::Application::Response.new] }
      let(:http_calling_method) { :cb_post }

      it 'returns an application response' do
        expect(client.create(criteria)).to be_a response_class
      end

      it 'sends #cb_post to api_client a uri with no did' do
        expected_uri = "/cbapi/application/"
        expect_any_instance_of(Cb::Utils::Api).to receive(http_calling_method).with(expected_uri, anything)
        subject
      end

      it_behaves_like 'it passes the correct headers'
    end

    describe '#update' do
      subject { client.update(criteria) }

      before { allow_any_instance_of(Cb::Utils::Api).to receive(:cb_put).and_return(response_stub) }
      let(:resume) { Criteria::Application::Resume.new }
      let(:cover_letter) { Criteria::Application::CoverLetter.new }
      let(:responses) { [Criteria::Application::Response.new] }
      let(:http_calling_method) { :cb_put }
      let(:criteria) do
        Criteria::Application::Update.new.resume(resume).cover_letter(cover_letter).responses(responses)
          .application_did('app_did').job_did('job_did')
      end

      it 'returns an application response' do
        expect(subject).to be_a response_class
      end

      it 'sends #cb_put to api_client a uri with the application_did' do
        expected_uri = "/cbapi/application/#{criteria.application_did}"
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_put).with(expected_uri, anything)
        subject
      end

      it_behaves_like 'it passes the correct headers'
    end

    describe '#form' do
      subject { client.form(did) }

      let(:did) { 'hotdog sandwich' }
      let(:http_calling_method) { :cb_get }
      let(:response_stub) { JSON.parse File.read('spec/support/response_stubs/application_form.json') }
      let(:response_class) { Cb::Responses::ApplicationForm }
      before { allow_any_instance_of(Cb::Utils::Api).to receive(http_calling_method).and_return(response_stub) }

      it 'GETs the correct url with supplied job did substituted in' do
        expected_uri = Cb.configuration.uri_application_form.sub(':did', did)
        expect_any_instance_of(Cb.api_client).to receive(http_calling_method).with(expected_uri, anything)
        subject
      end

      it 'returns an instance of the application form response class' do
        response = client.form(did)
        expect(response).to be_an_instance_of response_class
      end

      it_behaves_like 'it passes the correct headers'
    end
  end
end
