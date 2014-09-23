require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::Delete do

    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::Resumes::Delete.new({}) }

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_resume_delete.sub(':resume_hash', nil.to_s)
          @request.http_method.should == :delete
        end

        it 'should have a basic query string' do
          @request.query.should eq({ externalUserID: nil })
        end

        it 'should have basic headers' do
          @request.headers.should == {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          }
        end

        it 'should have a basic body' do
          @request.body.should == nil
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::Resumes::Delete.new({
                                                        resume_hash: 'resumeHash',
                                                        external_user_id: 'externalUserId'
                                                    })
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_resume_get.sub(':resume_hash', 'resumeHash')
          @request.http_method.should == :delete
        end

        it 'should have a basic query string' do
          @request.query.should eq ({ externalUserID: 'externalUserId' })
        end

        it 'should have basic headers' do
          @request.headers.should == {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          }
        end

        it 'should have a basic body' do
          @request.body.should == nil
        end
      end
    end

  end
end
