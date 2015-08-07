require 'spec_helper'
require 'support/mocks/resume'

module Cb
  describe Cb::Requests::Resumes::Put do

    context 'initialize without arguments' do
      context 'without arguments' do
        let (:request) { Cb::Requests::Resumes::Put.new({}) }

        it 'should be correctly configured' do
          expect(request.endpoint_uri).to eq(Cb.configuration.uri_resume_put.sub(':resume_hash', ''))
          expect(request.http_method).to eq(:put)
        end

        it 'should have a basic query string' do
          expect(request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(request.headers).to eq(
            {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json;version=1.0'
            }
          )
        end

        it 'should have a body' do
          expect(request.body).not_to eq(nil)
        end
      end

      context 'with arguments' do
        before :each do
          @resume = Mocks::Resume.snake_case_resume_hash
          @request = Cb::Requests::Resumes::Put.new(@resume)
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_resume_put.sub(':resume_hash', 'resumeHash'))
          expect(@request.http_method).to eq(:put)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq(
            {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json;version=1.0'
            }
          )
        end

        it 'should have a basic body' do
          expect(@request.body).to eq(Mocks::Resume.camel_case_resume_hash.to_json)
        end
      end
    end
  end
end
