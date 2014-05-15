require 'spec_helper'

module Cb
  describe Cb::Requests::User::Delete do

    context 'initialize without arguments' do
      it 'should not raise error' do
        expect{ Cb::Requests::User::Delete.new({}) }.to_not raise_error()
      end

      context 'without arguments' do
        before :each do
          @request = Cb::Requests::User::Delete.new({})
        end

        it 'should be correctly configured' do
          @request.uri_endpoint.should == Cb.configuration.uri_user_delete
          @request.http_method.should == :post
          @request.response_object.should == Cb::Responses::User::Delete
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
              <ExternalID>#{nil}</ExternalID>
              <Test>#{false}</Test>
              <Password>#{nil}</Password>
            </Request>
          eos
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::User::Delete.new({
              external_id: 'external id',
              test: 'true',
              password: 'password'
                                                    })
        end

        it 'should be correctly configured' do
          @request.uri_endpoint.should == Cb.configuration.uri_user_delete
          @request.http_method.should == :post
          @request.response_object.should == Cb::Responses::User::Delete
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
              <ExternalID>#{"external id"}</ExternalID>
              <Test>#{'true'}</Test>
              <Password>#{"password"}</Password>
            </Request>
          eos
        end
      end
    end

  end
end
