require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::Delete do

    context 'initialize without arguments' do
      context 'without arguments' do
        let(:request) { Cb::Requests::Resumes::Delete.new({}) }

        it 'will be correctly configured' do
          expect(request.endpoint_uri).to eq(Cb.configuration.uri_resume_delete.sub(':resume_hash', ''))
          expect(request.http_method).to eq(:delete)
        end

        it 'will have a basic query string' do
          expect(request.query).to eq({ externalUserID: nil })
        end

        it 'will have basic headers' do
          expect(request.headers).to eq({
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json;version=1.0'
          })
        end

        it 'will have a basic body' do
          expect(request.body).to eq(nil)
        end
      end

      context 'with arguments' do
        let(:request) { Cb::Requests::Resumes::Delete.new(resume_hash: 'resumeHash', external_user_id: 'externalUserId') }


        it 'will be correctly configured' do
          expect(request.endpoint_uri).to eq(Cb.configuration.uri_resume_get.sub(':resume_hash', 'resumeHash'))
          expect(request.http_method).to eq(:delete)
        end

        it 'will have a basic query string' do
          expect(request.query).to eq ({ externalUserID: 'externalUserId' })
        end

        it 'will have basic headers' do
          expect(request.headers).to eq({
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json;version=1.0'
          })
        end

        it 'will have a basic body' do
          expect(request.body).to eq(nil)
        end
      end
    end

  end
end
