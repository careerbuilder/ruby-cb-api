# Copyright 2016 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'cb/responses/user/check_existing'

module Cb
  describe Responses::User::CheckExisting do
    let(:json_hash) do
      {
        'Errors' => '',
        'ResponseUserCheck' => {
          'Request' => {
            'Email' => 'wut'
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
        expect(Responses::User::CheckExisting.new(json_hash)).to be_an_instance_of Responses::User::CheckExisting
      end

      context 'when input response hash cannot be validated due to' do
        context 'missing password node' do
          let(:json_hash) { { 'yey' => 'wow' } }

          it 'raises an error' do
            expect { Responses::User::CheckExisting.new(json_hash) }
              .to raise_error ExpectedResponseFieldMissing
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
