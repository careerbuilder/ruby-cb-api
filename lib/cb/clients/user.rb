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
require 'json'

module Cb
  module Clients
    class User < Base
      class << self
        def check_existing(email, password)
          xml = build_check_existing_request(email, password)
          response = cb_client.cb_post(Cb.configuration.uri_user_check_existing, body: xml)
          Cb::Responses::User::CheckExisting.new(response)
        end

        def temporary_password(external_id)
          query = { 'ExternalID' => external_id }
          response = cb_client.cb_get(Cb.configuration.uri_user_temp_password, query: query)
          Cb::Responses::User::TemporaryPassword.new(response)
        end

        def retrieve(external_id, _test_mode = false)
          cb_client = Cb::Utils::Api.instance
          json_hash = cb_client.cb_post Cb.configuration.uri_user_retrieve, body: build_retrieve_request(external_id, true)
          if json_hash.key? 'ResponseUserInfo'
            if json_hash['ResponseUserInfo'].key? 'UserInfo'
              user = Models::User.new json_hash['ResponseUserInfo']['UserInfo']
            end
            cb_client.append_api_responses user, json_hash['ResponseUserInfo']
          end

          cb_client.append_api_responses user, json_hash
        end

        def change_password(user_info)
          uri = Cb.configuration.uri_user_change_password
          response = cb_client.cb_post(uri, body: user_info.to_xml)

          Cb::Responses::User::ChangePassword.new(response) if response.key?('ResponseUserChangePW')
        end

        def delete(delete_criteria)
          uri = Cb.configuration.uri_user_delete
          response = cb_client.cb_post(uri, body: delete_criteria.to_xml)

          Cb::Responses::User::Delete.new(response) if response.key?('ResponseUserDelete')
        end

        private

        def build_check_existing_request(email, password)
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <Email>#{email}</Email>
              <Password>#{password}</Password>
              <Test>false</Test>
            </Request>
          eos
        end

        def build_retrieve_request(external_id, test_mode)
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>#{external_id}</ExternalID>
              <Test>#{test_mode}</Test>
            </Request>
          eos
        end

        def build_change_password_request(external_id, old_password, new_password, test_mode)
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>#{external_id}</ExternalID>
              <Test>#{test_mode}</Test>
              <OldPassword>#{old_password}</OldPassword>
              <NewPassword>#{new_password}</NewPassword>
            </Request>
          eos
        end
      end
    end
  end
end
