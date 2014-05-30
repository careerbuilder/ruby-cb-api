require 'spec_helper'

module Cb
  describe Cb::Requests::Category::Search do

    context 'initialize without arguments' do
      it 'should not raise error' do
        request = Cb::Requests::Category::Search.new({})
        expect { request.http_method }.to_not raise_error()
        expect { request.endpoint_uri }.to_not raise_error()
      end

      context 'without arguments' do
        before :each do
          @request = Cb::Requests::Category::Search.new({})
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_job_category_search
          @request.http_method.should == :get
        end

        it 'should have a basic query string' do
          @request.query.should == {
            CountryCode: nil
          }
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
          @request = Cb::Requests::Category::Search.new({
            host_site: 'Hello'
          })
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_job_category_search
          @request.http_method.should == :get
        end

        it 'should have a basic query string' do
          @request.query.should == {
            CountryCode: "Hello"
          }
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
