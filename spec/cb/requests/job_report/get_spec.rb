require 'spec_helper'

module Cb
  describe Requests::JobReport::Get do
    context 'initialize without arguments' do
      context 'without arguments' do
        let(:request) { Cb::Requests::JobReport::Get.new({}) }

        it 'should be correctly configured' do
          expect(request.endpoint_uri).to eq Cb.configuration.uri_job_report.sub(':job_did', '')
          expect(request.http_method).to eq :get
        end

        it 'should have nil query string' do
          expect(request.query).to eq( { UserOauthToken: nil } )
        end

        it 'should have basic headers' do
          expect(request.headers).to eq({
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          })
        end
      end

      context 'with arguments' do
        let(:request) {
          Cb::Requests::JobReport::Get.new({job_did: 'job_did', user_oauth_token: 'user_oauth_token' })
        }

        it 'should be correctly configured' do
          expect(request.endpoint_uri).to eq Cb.configuration.uri_job_report.sub(':job_did', 'job_did')
          expect(request.http_method).to eq :get
        end

        it 'should have nil query string' do
          expect(request.query).to eq( { UserOauthToken: 'user_oauth_token' } )
        end

        it 'should have basic headers' do
          expect(request.headers).to eq({
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          })
        end
      end
    end

  end
end
