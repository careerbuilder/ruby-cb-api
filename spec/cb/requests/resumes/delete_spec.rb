require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::Delete do

    context 'initialize without arguments' do
      context 'without arguments' do
        let(:request) { Cb::Requests::Resumes::Delete.new({}) }

        it 'will be correctly configured' do
          request.endpoint_uri.should == Cb.configuration.uri_resume_delete.sub(':resume_hash', '')
          request.http_method.should == :delete
        end

        it 'will have a basic query string' do
          request.query.should eq({ externalUserID: nil })
        end

        it 'will have basic headers' do
          request.headers.should == {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          }
        end

        it 'will have a basic body' do
          request.body.should == nil
        end
      end

      context 'with arguments' do
        let(:request) { Cb::Requests::Resumes::Delete.new(resume_hash: 'resumeHash', external_user_id: 'externalUserId') }


        it 'will be correctly configured' do
          request.endpoint_uri.should == Cb.configuration.uri_resume_get.sub(':resume_hash', 'resumeHash')
          request.http_method.should == :delete
        end

        it 'will have a basic query string' do
          request.query.should eq ({ externalUserID: 'externalUserId' })
        end

        it 'will have basic headers' do
          request.headers.should == {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          }
        end

        it 'will have a basic body' do
          request.body.should == nil
        end
      end
    end

  end
end
