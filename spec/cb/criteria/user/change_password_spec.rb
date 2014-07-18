require 'spec_helper'

module Cb
  describe Cb::Criteria::User::ChangePassword do

    before :all do
      @external_id                 = 'EXT135'
      @old_password                = 'MyOldPassword123'
      @new_password                = 'MyNewPassword123'
      @test                        = 'true'

      @user_change_password = Cb::Criteria::User::ChangePassword.new(
          :external_id => @external_id,
          :old_password => @old_password,
          :new_password => @new_password,
          :test => @test
      )
    end
    context '.new' do
      it 'should create an empty new change password object' do
        expect(@user_change_password.external_id).to eq @external_id
        expect(@user_change_password.old_password).to eq @old_password
        expect(@user_change_password.new_password).to eq @new_password
        expect(@user_change_password.test).to eq @test
      end
    end

    context '#to_xml' do
      it 'returns a string of valid XML' do
        returned_xml = @user_change_password.to_xml
        Nokogiri::XML::Document.parse(returned_xml)

        expect(returned_xml).to be_an_instance_of String
      end

    end
  end
end
