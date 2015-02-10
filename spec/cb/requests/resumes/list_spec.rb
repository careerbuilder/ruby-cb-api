require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::List do

    context 'initialize without arguments' do
      context 'without arguments' do
        let(:request) { Cb::Requests::Resumes::List.new({}) }

        it 'will be correctly configured' do
          expect(request.endpoint_uri).to eq(Cb.configuration.uri_resume_list)
          expect(request.http_method).to eq(:get)
        end

        it 'will have a basic query string' do
          expect(request.query).to eq({ HostSite: Cb.configuration.host_site, OAuthToken: nil })
        end

        it 'will have basic headers' do
          expect(request.headers).to eq(nil)
        end

        it 'will have a basic body' do
          expect(request.body).to eq(nil)
        end
      end

      context 'with arguments' do
        let(:request) { Cb::Requests::Resumes::List.new({ oauth_token: 'token' }) }

        it 'will be correctly configured' do
          expect(request.endpoint_uri).to eq(Cb.configuration.uri_resume_list)
          expect(request.http_method).to eq(:get)
        end

        it 'will have a basic query string' do
          expect(request.query).to eq ({ HostSite: Cb.configuration.host_site, OAuthToken: 'token' })
        end

        it 'will have basic headers' do
          expect(request.headers).to eq(nil)
        end

        it 'will have a basic body' do
          expect(request.body).to eq(nil)
        end
      end
    end

  end
end
