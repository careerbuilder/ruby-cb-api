require 'json'
require 'nokogiri'

module Cb
  class UserApi
    #############################################################
    ## Retrieve a user
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/UserInfo.aspx
    #############################################################
    def self.retrieve external_id, password, test_mode = false
      my_api = Cb::Utils::Api.new

      cb_response = my_api.cb_post Cb.configuration.uri_user_retrieve, :body => build_retrieve_request(external_id, password, test_mode)

      json_hash = JSON.parse cb_response.response.body

      user = CbUser.new json_hash['ResponseUserInfo']['UserInfo']

      my_api.append_api_responses user, json_hash['ResponseUserInfo']

      return user
    end

    #############################################################
    ## Change a user's password
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/UserInfo.aspx
    #############################################################
    def self.change_password external_id, old_password, new_password, test_mode = false
    	result = false

      my_api = Cb::Utils::Api.new
      cb_response = my_api.cb_post Cb.configuration.uri_user_change_password, :body => build_change_password_request(external_id, old_password, new_password, test_mode)
      json_hash = JSON.parse cb_response.response.body

      my_api.append_api_responses result, json_hash['ResponseUserChangePW']

      if result.cb_response.status.include? 'Success'
      	result = true
      	my_api.append_api_responses result, json_hash['ResponseUserChangePW']
      end

      result
    end

    #############################################################
    ## De-activate a user
    ##
    ## For detailed information around this API please visit:
    ## http://www.careerbuilder.com/api/UserInfo.aspx
    #############################################################
    def self.delete external_id, password, test_mode = false
      result = false

      my_api = Cb::Utils::Api.new
      cb_response = my_api.cb_post Cb.configuration.uri_user_delete, :body => build_delete_request(external_id, password, test_mode)
      json_hash = JSON.parse cb_response.response.body

      my_api.append_api_responses result, json_hash['ResponseUserDelete']

      if result.cb_response.status.include? 'Success'
        result = true
        my_api.append_api_responses result, json_hash['ResponseUserDelete']
      end

      result
    end

    private
    def self.build_retrieve_request external_id, password, test_mode
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