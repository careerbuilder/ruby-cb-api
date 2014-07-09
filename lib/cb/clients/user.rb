require 'json'

module Cb
  module Clients
    class User
      class << self

        def check_existing(email, password)
          xml = build_check_existing_request(email, password)
          response = api_client.cb_post(Cb.configuration.uri_user_check_existing, body: xml)
          Cb::Responses::User::CheckExisting.new(response)
        end

        def temporary_password(external_id)
          query = { 'ExternalID' => external_id }
          response = api_client.cb_get(Cb.configuration.uri_user_temp_password, query: query)
          Cb::Responses::User::TemporaryPassword.new(response)
        end

        def retrieve(external_id, test_mode = false)
          my_api = Cb::Utils::Api.instance
          json_hash = my_api.cb_post Cb.configuration.uri_user_retrieve, :body => build_retrieve_request(external_id, true)
          if json_hash.has_key? 'ResponseUserInfo'
            if json_hash['ResponseUserInfo'].has_key? 'UserInfo'
              user = Models::User.new json_hash['ResponseUserInfo']['UserInfo']
            end
            my_api.append_api_responses user, json_hash['ResponseUserInfo']
          end

          my_api.append_api_responses user, json_hash
        end

        def change_password(external_id, old_password, new_password, test_mode = false)
          result = false
          my_api = Cb::Utils::Api.instance
          json_hash = my_api.cb_post Cb.configuration.uri_user_change_password, :body => build_change_password_request(external_id, old_password, new_password, test_mode)

          if json_hash.has_key? 'ResponseUserChangePW'
            if json_hash['ResponseUserChangePW'].has_key?('Status') && json_hash['ResponseUserChangePW']['Status'].include?('Success')
              result = true
            end
            my_api.append_api_responses result, json_hash['ResponseUserChangePW']
          end

          my_api.append_api_responses result, json_hash
        end

        def delete(external_id, password, test_mode = false)
          result = Cb::Utils::MetaValues.new
          my_api = Cb::Utils::Api.instance
          json_hash = my_api.cb_post Cb.configuration.uri_user_delete, :body => build_delete_request(external_id, password, test_mode)

          if json_hash.has_key? 'ResponseUserDelete'
            if json_hash['ResponseUserDelete'].has_key?('Status') && json_hash['ResponseUserDelete']['Status'].include?('Success')
              result.class.send(:attr_reader, 'success')
              result.instance_variable_set(:@success, 'true')
            end
            my_api.append_api_responses result, json_hash['ResponseUserDelete']
          end

          my_api.append_api_responses result, json_hash
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
              <Test>#{test_mode.to_s}</Test>
            </Request>
          eos
        end

        def build_change_password_request(external_id, old_password, new_password, test_mode)
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>#{external_id}</ExternalID>
              <Test>#{test_mode.to_s}</Test>
              <OldPassword>#{old_password}</OldPassword>
              <NewPassword>#{new_password}</NewPassword>
            </Request>
          eos
        end

        def build_delete_request(external_id, password, test_mode)
          <<-eos
            <Request>
              <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
              <ExternalID>#{external_id}</ExternalID>
              <Test>#{test_mode.to_s}</Test>
              <Password>#{password}</Password>
            </Request>
          eos
        end

        def api_client
          Cb::Utils::Api.instance
        end

      end
    end
  end
end
