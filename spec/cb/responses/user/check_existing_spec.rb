require 'cb/responses/user/check_existing'

module Cb
  describe Responses::User::CheckExisting do
    let(:json_hash) do
      {
          'Errors' => '',
          'ResponseUserCheck' => {
            'Request' => {
                'Email' => "wut"
            },
            'UserCheckStatus' => 'walrus',
            'ResponseExternalID' => '1',
            'ResponseOAuthToken' => 'A',
            'ResponsePartnerID' => '5',
            'ResponseTempPassword' => 'false'
          }
      }
    end

    context '#new' do
      it 'returns a temp password response object' do
        Responses::User::CheckExisting.new(json_hash).should
        be_an_instance_of Responses::User::CheckExisting
      end

      context 'when input response hash cannot be validated due to' do
        context 'missing password node' do
          let(:json_hash) do { 'yey' => 'wow' } end

          it 'raises an error' do
            expect { Responses::User::CheckExisting.new(json_hash) }.
              to raise_error ExpectedResponseFieldMissing
          end
        end
      end
    end

    context '#models' do
      it 'returns the TemporaryPassword node from the response' do
        email = json_hash['ResponseUserCheck']['Request']['Email']
        status = json_hash['ResponseUserCheck']['UserCheckStatus']
        external_id = json_hash['ResponseUserCheck']['ResponseExternalID']
        oauth = json_hash['ResponseUserCheck']['ResponseOAuthToken']
        partner_id = json_hash['ResponseUserCheck']['ResponsePartnerID']
        temp_pw = false

        response = Responses::User::CheckExisting.new(json_hash)

        expect(response.model.email).to eq email
        expect(response.model.status).to eq status
        expect(response.model.external_id).to eq external_id
        expect(response.model.oauth_token).to eq oauth
        expect(response.model.partner_id).to eq partner_id
        expect(response.model.temp_password).to eq temp_pw
      end
    end
  end
end
