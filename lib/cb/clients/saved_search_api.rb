require 'json'
require 'nokogiri'

module Cb
  class SavedSearchApi
    #############################################################
    ## Retrieve a Saved Search
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################
    def self.retrieve external_id, test_mode = false
      my_api = Cb::Utils::Api.new

      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_retrieve, :body => build_retrieve_request(external_id, test_mode)

      json_hash = JSON.parse cb_response.response.body

      saved_search = SavedSearchApi.new json_hash['SavedJobSearch']['SavedSearch']

      my_api.append_api_responses user, json_hash['SavedJobSearch']

      return saved_search
    end

    #############################################################
    ## Update a Saved Search
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################
    def self.update external_id, test_mode = false
      result = false

      my_api = Cb::Utils::Api.new
      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_update, :body => build_edit_request(external_id, test_mode)
      json_hash = JSON.parse cb_response.response.body

      my_api.append_api_responses result, json_hash['SavedJobSearch']

      if result.cb_response.status.include? 'Success'
        result = true
        my_api.append_api_responses result, json_hash['SavedJobSearch']
      end

      result
    end

    #############################################################
    ## List of Saved Search's
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################
    def self.all external_id, test_mode = false
      result = false

      my_api = Cb::Utils::Api.new
      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_list, :body => build_list_request(external_id, test_mode)
      json_hash = JSON.parse cb_response.response.body

      my_api.append_api_responses result, json_hash['SavedJobSearch']

      if result.cb_response.status.include? 'Success'
        result = true
        my_api.append_api_responses result, json_hash['SavedJobSearch']
      end

      result
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

    def self.build_edit_request external_id, test_mode
      builder = Nokogiri::XML::Builder.new do
        Request {
          ExternalID_ external_id
          Test_ test_mode.to_s
          DeveloperKey_ Cb.configuration.dev_key
        }
      end

      builder.to_xml
    end

    def self.build_list_request external_id, password, test_mode
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