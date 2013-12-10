require 'spec_helper'

module Cb
    describe Cb::Clients::User do

      context '.retrieve' do
        before :each do
          stub_request(:post, uri_stem(Cb.configuration.uri_user_retrieve)).
            with(:body => anything).
            to_return(:body => { ResponseUserInfo: { Errors: nil, Status: 'Success (Test)', UserInfo: Hash.new } }.to_json)
        end

        it 'should retrieve a user' do
          user = Cb.user.retrieve 'XRHP5HT66R55L6RVP6R9', true

          expect(user.cb_response.errors.nil?).to be true
          expect(user.cb_response.status).to be == 'Success (Test)'
          expect(user.nil?).to be false
          user.api_error.should == false
        end
      end

      context '.change_password' do
        before :each do
          stub_request(:post, uri_stem(Cb.configuration.uri_user_change_password)).
            with(:body => anything).
            to_return(:body => { ResponseUserChangePW: { Status: 'Success (Test)' } }.to_json)
        end

        it 'should change a user password' do
          result = Cb.user.change_password 'XRHL3TC5VWHV37S9J55S', 'BikeTire3', 'BikeTire3', true

          expect(result.cb_response.errors.nil?).to eq true
          expect(result.cb_response.status).to eq 'Success (Test)'
          expect(result).to eq true
          result.api_error.should eq false
        end

    end

    context '.build_change_password_request' do
      it 'should build xml' do
        xml = Cb.user.send :build_change_password_request, 'a', 'b', 'c', true

        xml_wrapper = Nokogiri::XML.parse(xml).elements

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper[0].name).to be == 'Request' # Assert root node name.

        expect(xml.include?('<ExternalID>a</ExternalID>')).to be true
        expect(xml.include?('<OldPassword>b</OldPassword>')).to be true
        expect(xml.include?('<NewPassword>c</NewPassword>')).to be true
        expect(xml.include?('<Test>true</Test>')).to be true
        expect(xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>")).to be true
      end
    end

    context '.delete' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_user_delete)).
          with(:body => anything).
          to_return(:body => { ResponseUserDelete: { Status: 'Success (Test)' } }.to_json)
      end

      it 'should delete a user', :vcr => { :cassette_name => 'user/delete/success' } do
        result = Cb.user.delete 'xid', 'passwort', true

        expect(result.cb_response.errors.nil?).to be true
        expect(result.cb_response.status).to be == 'Success (Test)'
        expect(result).to be true
        result.api_error.should == false
      end
    end

    context '.build_retrieve_request' do
      it 'should build retriev a user' do
        xml = Cb.user.send :build_retrieve_request, 'a', true

        xml_wrapper = Nokogiri::XML.parse(xml).elements

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper[0].name).to be == 'Request' # Assert root node name.

        expect(xml.include?('<ExternalID>a</ExternalID>')).to be true
        expect(xml.include?('<Test>true</Test>')).to be true
        expect(xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>")).to be true
      end
    end

    context '.build_delete_request' do
      it 'should build delete xml' do
        xml = Cb.user.send :build_delete_request, 'a', 'b', true

        xml_wrapper = Nokogiri::XML.parse(xml).elements

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper[0].name).to be == 'Request' # Assert root node name.

        expect(xml.include?('<ExternalID>a</ExternalID>')).to be true
        expect(xml.include?('<Password>b</Password>')).to be true
        expect(xml.include?('<Test>true</Test>')).to be true
        expect(xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>")).to be true
      end
    end
  end
end