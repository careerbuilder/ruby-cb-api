require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::Put do

    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::Resumes::Put.new({}) }

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_resume_put.sub(':resume_hash', nil.to_s)
          @request.http_method.should == :put
        end


        it 'should have basic headers' do
          @request.headers.should == {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          }
        end

        it 'should have a body' do
          @request.body.should_not == nil
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::Resumes::Put.new({
                                                        resume_hash: 'resumeHash',
                                                        external_user_id: 'externalUserId'
                                                    })
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_resume_put.sub(':resume_hash', 'resumeHash')
          @request.http_method.should == :put
        end

        it 'should have basic headers' do
          @request.headers.should == {
                                     'DeveloperKey' => Cb.configuration.dev_key,
                                     'HostSite' => Cb.configuration.host_site,
                                     'Content-Type' => 'application/json'
                                     }
        end

        it 'should have a basic body' do
          @request.body.should_not == nil
        end
      end
    end

  end
end
