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
      let(:response) do
        Clients::User.check_existing 'kyle@cb.gov', '1337'
      end

      before do
        stub_request(:post, uri_stem(Cb.configuration.uri_user_check_existing)).to_return(body: body.to_json)
      end

      context 'positive tests' do
        let(:body) do
          { ResponseUserCheck: { Request: { Email: 'kyle@cb.gov' }, Status: 'Success', UserCheckStatus: 'EmailExistsPasswordsDoNotMatch', ResponseExternalID: 'abc123', ResponseOAuthToken: '456xyz', ResponsePartnerID: 'zyx654', ResponseTempPassword: 'True' } }
        end

        context 'by interacting with the API client directly' do
          it 'returns a CheckExisting response' do
            expect(response).to be_a Responses::User::CheckExisting
          end
        end

        context 'When external id comes back' do
          it 'external_id should not be nil' do
            expect(response.model.external_id).to eq('abc123')
          end
        end

        context 'When ResponseTempPassword comes back' do
          it 'temp_password should be true' do
            expect(response.model.temp_password).to eq(true)
          end
        end

        context 'When oauth token comes back' do
          it 'oauth_token should not be nil' do
            expect(response.model.oauth_token).to eq('456xyz')
          end
        end

        context 'When partner id comes back' do
          it 'partner_id should not be nil' do
            expect(response.model.partner_id).to eq('zyx654')
          end
        end

        context 'When user check status comes back' do
          it 'status should not be nil' do
            expect(response.model.status).to eq('EmailExistsPasswordsDoNotMatch')
          end
        end

        context 'When email comes back' do
          it 'email should not be nil' do
            expect(response.model.email).to eq('kyle@cb.gov')
          end
        end

        it 'builds xml correctly' do
          body = <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <Email>k@cb.com</Email>
              <Password>moom</Password>
              <Test>false</Test>
            </Request>
          eos
          expect_any_instance_of(Cb::Utils::Api).to receive(:cb_post).with(anything, body: body)
                                                      .and_return(JSON.parse(body.to_json))

          Cb.user.check_existing 'k@cb.com', 'moom'
        end
      end

      context 'negative tests' do
        let(:body) do
          { ResponseUserCheck: { Request: { Email: 'kyle@cb.gov' }, Status: 'Success', UserCheckStatus: 'EmailExistsPasswordsDoNotMatch', ResponseExternalID: 'abc123', ResponseOAuthToken: '456xyz', ResponsePartnerID: 'zyx654', ResponseTempPassword: 'False' } }
        end

        context 'When ResponseTempPassword comes back false' do
          it 'temp_password should be false' do
            expect(response.model.temp_password).to eq(false)
          end
        end

        context 'When ResponseTempPassword comes back nil (not present in response)' do
          let(:body) do
            { ResponseUserCheck: { Request: { Email: 'kyle@cb.gov' }, Status: 'Success', UserCheckStatus: 'EmailExistsPasswordsDoNotMatch', ResponseExternalID: 'abc123', ResponseOAuthToken: '456xyz', ResponsePartnerID: 'zyx654' } }
          end

          it 'temp_password should be false' do
            expect(response.model.temp_password).to eq(false)
          end
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
        expect(user.api_error).to eq(false)
      end
    end

    context '.delete' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_user_delete)).
          with(:body => anything).
          to_return(:body => { ResponseUserDelete: { Request: {}, Status: 'Success (Test)' } }.to_json)
      end

      it 'should delete a user', :vcr => { :cassette_name => 'user/delete/success' } do
        result = Cb.user.delete(Cb::Criteria::User::Delete.new(external_id: 'xid', password: 'passwort'))

        expect(result).to be_an_instance_of Cb::Responses::User::Delete
        expect(result.model.nil?).to be false
        expect(result.model.status).to eq 'Success (Test)'
      end
    end

    describe '#retrieve' do
      it 'builds xml correctly' do
        body = <<-eos
          <Request>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <ExternalID>ext_id</ExternalID>
            <Test>true</Test>
          </Request>
        eos

        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_post).with(anything, body: body)
        Cb.user.retrieve 'ext_id', true
      end
    end

    describe '#delete' do
      it 'builds xml correctly' do
        body = <<-eos
        <?xml version="1.0"?>
          <Request>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <Password>pw</Password>
            <ExternalID>ext_id</ExternalID>
            <Test>true</Test>
          </Request>
        eos
        expect_any_instance_of(Cb::Utils::Api).to receive(:cb_post).with(anything, body: body)
        Cb.user.delete(Cb::Criteria::User::Delete.new(external_id: 'ext_id', password: 'pw', test: true))
      end
    end

    describe  '#change_pwd' do
      context 'When an user makes a change password request' do
        let(:user_info_change_password) {
          Cb::Criteria::User::ChangePassword.new({
                                                   external_id: '123TEST',
                                                   old_password: 'MyPassWord123',
                                                   new_password: 'MyNewPassword123',
                                                   test: 'false'
                                                 }) }
        let(:api_return_fail) do { 'ResponseUserChangePW' => { 'Request' => { 'ExternalID' => 'EXT12345', 'Errors' => 'An error occurred' }, 'Status' => 'Fail' } } end
        let(:api_return_success) do { 'ResponseUserChangePW' => { 'Request' => { 'ExternalID' => 'EXT12345', 'Errors' => '' }, 'Status' => 'Success' } } end

        it 'should return a proper response when the change password call fails' do
          allow_any_instance_of(Cb::Utils::Api).to receive(:cb_post).and_return(api_return_fail)
          response = Cb.user.change_password(user_info_change_password).model
          expect(response.status).to eq 'Fail'
        end

        it 'should return a proper response when the change password call succeeds' do
          allow_any_instance_of(Cb::Utils::Api).to receive(:cb_post).and_return(api_return_success)
          response = Cb.user.change_password(user_info_change_password).model
          expect(response.status).to eq 'Success'
        end
      end
    end
  end
end
