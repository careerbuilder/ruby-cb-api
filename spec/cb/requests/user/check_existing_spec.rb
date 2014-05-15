require 'spec_helper'

module Cb
  describe Cb::Requests::User::CheckExisting do

    context 'initialize' do
      it 'should not raise error' do
        expect{ Cb::Requests::User::CheckExisting.new({}) }.to_not raise_error()
      end

      it 'should be correctly configured' do
        request = Cb::Requests::User::CheckExisting.new({})
        request.uri_endpoint.should == Cb.configuration.uri_user_check_existing
        request.http_method.should == :post
        request.response_object.should == Cb::Responses::User::CheckExisting
      end
    end

  end
end
