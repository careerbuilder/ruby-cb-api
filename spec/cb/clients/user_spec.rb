require 'spec_helper'

module Cb
  describe Cb::Clients::User do

    describe '#check_existing' do
      let(:body) do
        { ResponseUserCheck: { Request: { Email: 'kyle@cb.gov' }, Status: 'Success', UserCheckStatus: 'EmailExistsPasswordsDoNotMatch', ResponseExternalID: 'abc123', ResponseOAuthToken: '456xyz' } }
      end
      before do
        stub_request(:post, uri_stem(Cb.configuration.uri_user_check_existing)).to_return(body: body.to_json)
      end

      context 'by interacting with the API client directly' do
        it 'returns a CheckExisting response' do
          response = Clients::User.check_existing 'kyle@cb.gov', '1337'
          response.should be_a Responses::User::CheckExisting
        end
      end

      context 'When external id comes back' do
        it 'external_id should not be nil' do
          response = Clients::User.check_existing 'kyle@cb.gov', '1337'
          response.model.external_id.should_not be_nil
          response.model.external_id == 'abc123'
        end
      end

      context 'When oauth token comes back' do
        it 'oauth_token should not be nil' do
          response = Clients::User.check_existing 'kyle@cb.gov', '1337'
          response.model.oauth_token.should_not be_nil
          response.model.oauth_token == '456xyz'
        end
      end

      context 'When user check status comes back' do
        it 'status should not be nil' do
          response = Clients::User.check_existing 'kyle@cb.gov', '1337'
          response.model.status.should == 'EmailExistsPasswordsDoNotMatch'
        end
      end

      context 'When email comes back' do
        it 'email should not be nil' do
          response = Clients::User.check_existing 'kyle@cb.gov', '1337'
          response.model.email.should == 'kyle@cb.gov'
        end
      end

    end

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

        xml_wrapper = XmlSimple.xml_in xml, {'KeepRoot' => true}

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper.has_key? 'Request').to be true # Assert root node name.

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

        xml_wrapper = XmlSimple.xml_in xml, {'KeepRoot' => true}

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper.has_key? 'Request').to be true # Assert root node name.

        expect(xml.include?('<ExternalID>a</ExternalID>')).to be true
        expect(xml.include?('<Test>true</Test>')).to be true
        expect(xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>")).to be true
      end
    end

    context '.build_delete_request' do
      it 'should build delete xml' do
        xml = Cb.user.send :build_delete_request, 'a', 'b', true

        xml_wrapper = XmlSimple.xml_in xml, {'KeepRoot' => true}

        expect(xml_wrapper.count).to be == 1 # Assert one root node.
        expect(xml_wrapper.has_key? 'Request').to be true  # Assert root node name.

        expect(xml.include?('<ExternalID>a</ExternalID>')).to be true
        expect(xml.include?('<Password>b</Password>')).to be true
        expect(xml.include?('<Test>true</Test>')).to be true
        expect(xml.include?("<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>")).to be true
      end
    end

  end
end
