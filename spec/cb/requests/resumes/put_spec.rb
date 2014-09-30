require 'spec_helper'
require 'support/mocks/resume'

module Cb
  describe Cb::Requests::Resumes::Put do

    context 'initialize without arguments' do
      context 'without arguments' do
        let (:request) { Cb::Requests::Resumes::Put.new({}) }

        it 'should be correctly configured' do
          request.endpoint_uri.should == Cb.configuration.uri_resume_put.sub(':resume_hash', '')
          request.http_method.should == :put
        end

        it 'should have a basic query string' do
          request.query.should == nil
        end

        it 'should have basic headers' do
          request.headers.should ==
            {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
            }
        end

        it 'should have a body' do
          request.body.should_not == nil
        end
      end

      context 'with arguments' do
        before :each do
          @resume = Mocks::Resume.snake_case_resume_hash
          @request = Cb::Requests::Resumes::Put.new(@resume)
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_resume_put.sub(':resume_hash', 'resumeHash')
          @request.http_method.should == :put
        end

        it 'should have basic headers' do
          @request.headers.should ==
            {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
            }
        end

        it 'should have a basic body' do
          @request.body.should == Mocks::Resume.camel_case_resume_hash.to_json
        end
      end
    end
  end
end
