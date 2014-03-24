require 'spec_helper'

module Cb
  describe Cb::Clients::User do

    describe '#temporary_password' do
      before do
        stub_request(:get, uri_stem(Cb.configuration.uri_user_temp_password)).
          with(:query => anything).
          to_return(:body => { Errors: [], TemporaryPassword: 'hotdogs!' }.to_json)
      end

      it 'requires a single param (external id)' do
        expect { Cb.user.temporary_password }.to raise_error(ArgumentError) do |arg_error|
          expect(arg_error.message).to eq 'wrong number of arguments (0 for 1)'
        end
      end

      context 'response' do
        it 'responds to a #temp_password method' do
          response = Cb.user.temporary_password('ex_id')
          expect(response.temp_password).to eq 'hotdogs!'
        end

        it '#temp_password just aliases the normal #model methods' do
          response = Cb.user.temporary_password('ex_id')
          expect(response.temp_password).to eq response.models
          expect(response.temp_password).to eq response.model
        end
      end
    end

    describe '#check_existing' do
      let(:body) do
        { ResponseUserCheck: { Request: { Email: 'kyle@cb.gov' }, Status: 'Success', UserCheckStatus: 'EmailExistsPasswordsDoNotMatch', ResponseExternalID: 'abc123', ResponseOAuthToken: '456xyz', ResponsePartnerID: 'zyx654' } }
      end

      let(:response) do
        Clients::User.check_existing 'kyle@cb.gov', '1337'
      end

      before do
        stub_request(:post, uri_stem(Cb.configuration.uri_user_check_existing)).to_return(body: body.to_json)
      end

      context 'by interacting with the API client directly' do
        it 'returns a CheckExisting response' do
          response.should be_a Responses::User::CheckExisting
        end
      end

      context 'When external id comes back' do
        it 'external_id should not be nil' do
          response.model.external_id.should == 'abc123'
        end
      end

      context 'When oauth token comes back' do
        it 'oauth_token should not be nil' do
          response.model.oauth_token.should == '456xyz'
        end
      end

      context 'When partner id comes back' do
        it 'partner_id should not be nil' do
          response.model.partner_id.should == 'zyx654'
        end
      end

      context 'When user check status comes back' do
        it 'status should not be nil' do
          response.model.status.should == 'EmailExistsPasswordsDoNotMatch'
        end
      end

      context 'When email comes back' do
        it 'email should not be nil' do
          response.model.email.should == 'kyle@cb.gov'
        end
      end

      it 'builds xml correctly' do
        Cb::Utils::Api.any_instance.should_receive(:cb_post).with do |uri, options|
          options[:body].should eq <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <Email>k@cb.com</Email>
              <Password>moom</Password>
              <Test>false</Test>
            </Request>
          eos
        end.and_return(JSON.parse(body.to_json))

        Cb.user.check_existing 'k@cb.com', 'moom'
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

    describe '#change_password' do
      it 'builds xml correctly' do
        Cb::Utils::Api.any_instance.should_receive(:cb_post).with do |uri, options|
          options[:body].should eq <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>ext_id</ExternalID>
              <Test>true</Test>
              <OldPassword>old_pw</OldPassword>
              <NewPassword>new_pw</NewPassword>
            </Request>
          eos
        end.and_return({})

        Cb.user.change_password 'ext_id', 'old_pw', 'new_pw', true
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

    describe '#retrieve' do
      it 'builds xml correctly' do
        Cb::Utils::Api.any_instance.should_receive(:cb_post).with do |uri, options|
          options[:body].should eq <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>ext_id</ExternalID>
              <Test>true</Test>
            </Request>
          eos
        end.and_return({})

        Cb.user.retrieve 'ext_id', true
      end
    end

    describe '#delete' do
      it 'builds xml correctly' do
        Cb::Utils::Api.any_instance.should_receive(:cb_post).with do |uri, options|
          options[:body].should eq <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>ext_id</ExternalID>
              <Test>true</Test>
              <Password>pw</Password>
            </Request>
          eos
        end.and_return({})

        Cb.user.delete 'ext_id', 'pw', true
      end
    end

  end
end
