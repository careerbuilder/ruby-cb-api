require 'spec_helper'

module Cb
  describe Cb::Requests::Company::Find do

    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::Company::Find.new({}) }

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_company_find
          @request.http_method.should == :get
        end

        it 'should have a basic query string' do
          @request.query.should == {:CompanyDID => nil, :HostSite=> Cb.configuration.host_site}
        end

        it 'should have basic headers' do
          @request.headers.should == nil
        end

        it 'should have a basic body' do
          @request.body.should == nil
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::Company::Find.new({
            did: "hello"
          })
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_company_find
          @request.http_method.should == :get
        end

        it 'should have a basic query string' do
          @request.query.should == {:CompanyDID => "hello", :HostSite=> Cb.configuration.host_site}
        end

        it 'should have basic headers' do
          @request.headers.should == nil
        end

        it 'should have a basic body' do
          @request.body.should == nil
        end
      end
    end

  end
end
