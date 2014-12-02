require 'spec_helper'
require 'support/mocks/resume'

module Cb
  describe Cb::Requests::Resumes::Post do

    context 'initialize without arguments' do
      context 'without arguments' do
        let (:request) { Cb::Requests::Resumes::Post.new({}) }

        it 'should be correctly configured' do
          request.endpoint_uri.should == Cb.configuration.uri_resume_post.sub(':resume_hash', '')
          request.http_method.should == :post
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
        let(:resume) { Mocks::Resume.snake_case_resume_hash }
        let(:request) { Cb::Requests::Resumes::Post.new(resume) }

        it 'should be correctly configured' do
          request.endpoint_uri.should eql Cb.configuration.uri_resume_post.sub(':resume_hash', 'resumeHash')
          request.http_method.should eql :put
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
