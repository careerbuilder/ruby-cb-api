require 'spec_helper'

module Cb
  describe Cb::Requests::User::ChangePassword do

    context 'initialize without arguments' do
      it 'should not raise error' do
        request = Cb::Requests::User::ChangePassword.new({})
        expect { request.http_method }.to_not raise_error()
        expect { request.endpoint_uri }.to_not raise_error()
      end

      context 'without arguments' do
        before :each do
          @request = Cb::Requests::User::ChangePassword.new({})
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_user_change_password
          @request.http_method.should == :post
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
              <Test>#{false.to_s}</Test>
              <OldPassword>#{nil}</OldPassword>
              <NewPassword>#{nil}</NewPassword>
            </Request>
          eos
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::User::ChangePassword.new({
            external_id: 'external id',
            test: 'true',
            old_password: 'old password',
            new_password: 'new password'
          })
        end

        it 'should be correctly configured' do
          @request.endpoint_uri.should == Cb.configuration.uri_user_change_password
          @request.http_method.should == :post
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
              <ExternalID>#{'external id'}</ExternalID>
              <Test>#{'true'}</Test>
              <OldPassword>#{'old password'}</OldPassword>
              <NewPassword>#{'new password'}</NewPassword>
            </Request>
          eos
        end
      end
    end

  end
end
