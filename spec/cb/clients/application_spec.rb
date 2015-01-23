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
        allow_any_instance_of(Cb::Utils::Api).to receive(:cb_get).and_return(response_stub)
      }
      let(:criteria) { Criteria::Application::Get.new.application_did('app_did') }

      it 'returns an application response' do
        expect(
          client.get(criteria)
        ).to be_a Responses::Application
      end

      it 'sends #cb_get to api_client a uri with the application_did' do
        expected_uri = "/cbapi/application/#{criteria.application_did}"
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_get).with(expected_uri, anything)

        client.get(criteria)
      end

      it 'sends #cb_get to api_client headers with the developer_key' do
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_get).with { |instance, uri, hash|
          hash[:headers]['DeveloperKey'] == 'mydevkey'
        }

        client.get(criteria)
      end

      it 'sends #cb_get to api_client headers with the host_site' do
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_get).with { |instance, uri, hash|
          hash[:headers]['HostSite'] == 'US'
        }

        client.get(criteria)
      end
    end

    describe '#create' do
      before { allow_any_instance_of(Cb::Utils::Api).to receive(:cb_post).and_return(response_stub) }
      let(:criteria) { Criteria::Application::Create.new.resume(resume).cover_letter(cover_letter).responses(responses).host_site(host_site) }
      let(:host_site) { nil }
      let(:resume) { Criteria::Application::Resume.new }
      let(:cover_letter) { Criteria::Application::CoverLetter.new }
      let(:responses) { [Criteria::Application::Response.new] }

      it 'returns an application response' do
        expect(
          client.create(criteria)
        ).to be_a Responses::Application
      end

      it 'sends #cb_post to api_client a uri with no did' do
        expected_uri = "/cbapi/application/"
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_post).with(expected_uri, anything)

        client.create(criteria)
      end

      it 'sends #cb_post to api_client headers with the developer_key' do
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_post).with { |instance, uri, hash|
          hash[:headers]['DeveloperKey'] == 'mydevkey'
        }

        client.create(criteria)
      end

      it 'sends #cb_post to api_client headers with the host_site' do
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_post).with { |instance, uri, hash|
          hash[:headers]['HostSite'] == 'US'
        }

        client.create(criteria)
      end

      context 'when we receive a host site in our criteria' do
        let(:host_site) { 'GR' }
        
        it 'sends #cb_post to api_client headers with the host_site from criteria' do
          expect_any_instance_of(Cb::Utils::Api).to receive(:cb_post).with { |instance, uri, hash|
            hash[:headers]['HostSite'] == 'GR'
          }

          client.create(criteria)
        end
      end
    end

    describe '#update' do
      before {
        allow_any_instance_of(Cb::Utils::Api).to receive(:cb_put).and_return(response_stub)
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

      it 'sends #cb_put to api_client a uri with the application_did' do
        expected_uri = "/cbapi/application/#{criteria.application_did}"
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_put).with(expected_uri, anything)

        client.update(criteria)
      end

      it 'sends #cb_put to api_client headers with the developer_key' do
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_put).with { |instance, uri, hash|
          hash[:headers]['DeveloperKey'] == 'mydevkey'
        }

        client.update(criteria)
      end

      it 'sends #cb_put to api_client headers with the host_site' do
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_put).with { |instance, uri, hash|
          hash[:headers]['HostSite'] == 'US'
        }

        client.update(criteria)
      end

    end

    describe '#form' do
      let(:did) { 'hotdog sandwich' }
      let(:response_stub) { JSON.parse File.read('spec/support/response_stubs/application_form.json') }
      before { allow_any_instance_of(Cb::Utils::Api).to receive(:cb_get).and_return(response_stub) }

      it 'GETs the correct url with supplied job did substituted in' do
        expected_uri = Cb.configuration.uri_application_form.sub(':did', did)
        expect_any_instance_of(Cb.api_client).to receive(:cb_get).with(expected_uri, anything)
        client.form(did)
      end

      it 'returns an instance of the application form response class' do
        response = client.form(did)
        expect(response).to be_an_instance_of Cb::Responses::ApplicationForm
      end

      it 'sends hostsite and developer key in the headers' do
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_get).with { |instance, uri, hash|
          hash[:headers]['HostSite'] == 'US'
          hash[:headers]['DeveloperKey'] == 'mydevkey'
        }

        client.form(did)
      end
    end
  end
end
