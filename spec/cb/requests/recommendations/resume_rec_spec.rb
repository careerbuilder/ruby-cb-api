require 'spec_helper'

module Cb
  describe Cb::Requests::Recommendations::Resume do

    context 'initialize without arguments' do
      context 'without arguments' do
        let(:request) { Cb::Requests::Recommendations::Resume.new({}) }

        it 'should be correctly configured' do
          request.endpoint_uri.should == Cb.configuration.uri_recommendation_for_resume.sub(':resume_hash', nil.to_s)
          request.http_method.should == :get
        end

        it 'should have a basic query string' do
          request.query.should eq({ externalID: nil })
        end

        it 'should have basic headers' do
          request.headers.should == {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          }
        end

        it 'should have a basic body' do
          request.body.should == nil
        end
      end

      context 'with arguments' do
          let (:request) { Cb::Requests::Recommendations::Resume.new({
                                                                       resume_hash: 'resumeHash',
                                                                       external_user_id: 'externalUserId'
                                                                      })}

        it 'should be correctly configured' do
          request.endpoint_uri.should == Cb.configuration.uri_recommendation_for_resume.sub(':resume_hash', 'resumeHash')
          request.http_method.should == :get
        end

        it 'should have a basic query string' do
          request.query.should eq ({ externalID: 'externalUserId' })
        end

        it 'should have basic headers' do
          request.headers.should == {
              'DeveloperKey' => Cb.configuration.dev_key,
              'HostSite' => Cb.configuration.host_site,
              'Content-Type' => 'application/json'
          }
        end

        it 'should have a basic body' do
          request.body.should == nil
        end
      end
    end
  end
end