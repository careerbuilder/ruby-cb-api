require 'json'
require 'nokogiri'

module Cb
  class SavedSearchApi

    #############################################################
    ## Create a Saved Search
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################
    def self.create params
      my_api = Cb::Utils::Api.new

      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_create, :body => CbSavedSearch.new(params)

      json_hash = JSON.parse cb_response.response.body

      saved_search = SavedSearchApi.new json_hash['SavedJobSearch']['SavedSearch']

      my_api.append_api_responses saved_search, json_hash['SavedJobSearch']

      return saved_search
    end

    #############################################################
    ## Retrieve a Saved Search
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################
    def self.retrieve external_id, external_user_id
      my_api = Cb::Utils::Api.new

      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_retrieve, :body => build_retrieve_request(external_id, external_user_id)

      json_hash = JSON.parse cb_response.response.body

      saved_search = SavedSearchApi.new json_hash['SavedJobSearch']['SavedSearch']

      my_api.append_api_responses saved_search, json_hash['SavedJobSearch']

      return saved_search
    end

    #############################################################
    ## Update a Saved Search
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################
    def self.update params
      result = false

      my_api = Cb::Utils::Api.new
      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_update, :body => CbSavedSearch.new(params)
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
    def self.all external_id, external_user_id
      my_api = Cb::Utils::Api.new

      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_retrieve, :body => build_retrieve_request(external_id, external_user_id)

      json_hash = JSON.parse cb_response.response.body

      saved_search = SavedSearchApi.new json_hash['SavedJobSearch']['SavedSearch']

      my_api.append_api_responses saved_search, json_hash['SavedJobSearch']

      return saved_search
    end

    private
    def self.build_retrieve_request external_id, external_user_id
      builder = Nokogiri::XML::Builder.new do
        Request {
          ExternalID_ external_id
          ExternalUserID_ external_user_id
          DeveloperKey_ Cb.configuration.dev_key
        }
      end

      builder.to_xml
    end

    def self.build_list_request external_user_id
      builder = Nokogiri::XML::Builder.new do
        Request {
          ExternalUserID_ external_user_id
          DeveloperKey_ Cb.configuration.dev_key
        }
      end

      builder.to_xml
    end

  end
end