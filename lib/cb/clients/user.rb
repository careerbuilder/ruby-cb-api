require 'json'
require 'nokogiri'

module Cb
  module Clients
    class User

      def self.retrieve external_id, test_mode = false
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_user_retrieve, :body => build_retrieve_request(external_id, true)

        if json_hash.has_key? 'ResponseUserInfo'
          if json_hash['ResponseUserInfo'].has_key? 'UserInfo'
            user = Models::User.new json_hash['ResponseUserInfo']['UserInfo']
          end
          my_api.append_api_responses user, json_hash['ResponseUserInfo']
        end

        my_api.append_api_responses user, json_hash
      end

      def self.change_password external_id, old_password, new_password, test_mode = false
        result = false
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_user_change_password, :body => build_change_password_request(external_id, old_password, new_password, test_mode)

        if json_hash.has_key? 'ResponseUserChangePW'
          if json_hash['ResponseUserChangePW'].has_key?('Status') && json_hash['ResponseUserChangePW']['Status'].include?('Success')
            result = true
          end
          my_api.append_api_responses result, json_hash['ResponseUserChangePW']
        end

        my_api.append_api_responses result, json_hash
      end

      def self.delete external_id, password, test_mode = false
        result = false
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_user_delete, :body => build_delete_request(external_id, password, test_mode)

        if json_hash.has_key? 'ResponseUserDelete'
          if json_hash['ResponseUserDelete'].has_key?('Status') && json_hash['ResponseUserDelete']['Status'].include?('Success')
            result = true
          end
          my_api.append_api_responses result, json_hash['ResponseUserDelete']
        end

        my_api.append_api_responses result, json_hash
      end

      private
      def self.build_retrieve_request external_id, test_mode
        builder = Nokogiri::XML::Builder.new do
          Request {
            ExternalID_ external_id
            Test_ test_mode.to_s
            DeveloperKey_ Cb.configuration.dev_key
          }
        end

        builder.to_xml
      end

      def self.build_change_password_request external_id, old_password, new_password, test_mode
        builder = Nokogiri::XML::Builder.new do
          Request {
            ExternalID_ external_id
            OldPassword_ old_password
            NewPassword_ new_password
            Test_ test_mode.to_s
            DeveloperKey_ Cb.configuration.dev_key
          }
        end

        builder.to_xml
      end

      def self.build_delete_request external_id, password, test_mode
        builder = Nokogiri::XML::Builder.new do
          Request {
            ExternalID_ external_id
            Password_ password
            Test_ test_mode.to_s
            DeveloperKey_ Cb.configuration.dev_key
          }
        end

        builder.to_xml
      end

    end
  end
end
