require 'spec_helper'

module Cb
  describe Cb::Requests::User::CheckExisting do

    context 'initialize without arguments' do
      it 'should not raise error' do
        expect{ Cb::Requests::User::CheckExisting.new({}) }.to_not raise_error()
      end

      context 'without arguments' do
        before :each do
          @request = Cb::Requests::User::CheckExisting.new({})
        end

        it 'should be correctly configured' do
          @request.uri_endpoint.should == Cb.configuration.uri_user_check_existing
          @request.http_method.should == :post
          @request.response_object.should == Cb::Responses::User::CheckExisting
        end

        it 'should have a basic query string' do
          @request.query.should == nil
        end

        it 'should have basic headers' do
          @request.headers.should == nil
        end

        it 'should have a basic body' do
          @request.body.should == <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <Email>#{nil}</Email>
              <Password>#{nil}</Password>
              <Test>false</Test>
            </Request>
          eos
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::User::CheckExisting.new({
              email: "email",
              password: "password"
                                                           })
        end

        it 'should be correctly configured' do
          @request.uri_endpoint.should == Cb.configuration.uri_user_check_existing
          @request.http_method.should == :post
          @request.response_object.should == Cb::Responses::User::CheckExisting
        end

        it 'should have a basic query string' do
          @request.query.should == nil
        end

        it 'should have basic headers' do
          @request.headers.should == nil
        end

        it 'should have a basic body' do
          @request.body.should == <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <Email>#{"email"}</Email>
              <Password>#{"password"}</Password>
              <Test>false</Test>
            </Request>
          eos
        end
      end
    end

  end
end