require 'spec_helper'

module Cb
  describe Cb::Requests::JobReport::Get do
    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::JobReport::Get.new({}) }

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_job_report.sub(':job_did', '')
          @request.http_method.should == :get
        end

        it 'should have a basic query string' do
          @request.query.should == nil
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
          @request = Cb::Requests::JobReport::Get.new({job_did: 'job_did', user_oauth_token: 'user_oauth_token' })
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_job_report.sub(':job_did', 'mao')
          @request.http_method.should == :get
        end

        it 'should have a basic query string' do
          @request.query.should == nil
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
