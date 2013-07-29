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
      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_create, :body => CbSavedSearch.new(params).to_xml
      json_hash = JSON.parse cb_response.response.body
      saved_search = CbSavedSearch.new json_hash['SavedJobSearch']
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
      my_api = Cb::Utils::Api.new
      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_update, :body => CbSavedSearch.new(params).to_xml
      json_hash = JSON.parse cb_response.response.body
      saved_search = CbSavedSearch.new json_hash['SavedJobSearch']
      my_api.append_api_responses saved_search, json_hash['SavedJobSearch']

      return saved_search
    end

    #############################################################
    ## Delete a Saved Search
    ## (Returns Boolean: Cb::SavedSearchApi.delete? => true/false)
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################

    def self.delete params #developer_key, external_user_id, external_id, host_site
      result = false

      my_api = Cb::Utils::Api.new
      #cb_response = my_api.cb_post Cb.configuration.uri_saved_search_delete, :query => {:developerkey=> developer_key, :externaluserid=> external_user_id, :externalid=> external_id, :hostsite=> host_site}
      cb_response = my_api.cb_post Cb.configuration.uri_saved_search_delete, CbSavedSearch.new(params).to_xml
      json_hash = JSON.parse cb_response.response.body

      my_api.append_api_responses result, json_hash['SavedJobSearch']

      if result.cb_response.status.include? 'Success'
        result = true
        my_api.append_api_responses result, json_hash['SavedJobSearch']
      end

      result
    end

    #############################################################
    ## Retrieve a Saved Search
    ##
    ## external_id is the unique ID for the specific Saved Search
    ## that is being requested from the API. This External_id is
    ## found from running a SavedSearchApi.all call. This is a
    ## 64 character long ID.
    ##
    ## HostSite (From Saved Search List) Required*
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################
    def self.retrieve developer_key, external_user_id, external_id, host_site
      my_api = Cb::Utils::Api.new
      cb_response = my_api.cb_get Cb.configuration.uri_saved_search_retrieve, :query => {:developerkey=> developer_key, :externaluserid=> external_user_id, :externalid=> external_id, :hostsite=> host_site}
      json_hash = JSON.parse cb_response.response.body
      saved_search = CbSavedSearch.new json_hash['SavedJobSearch']
      my_api.append_api_responses saved_search, json_hash['SavedJobSearch']

      return saved_search
    end

    #############################################################
    ## List of Saved Search's
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/savedsearchinfo.aspx
    #############################################################
    def self.list developer_key, external_user_id
      my_api = Cb::Utils::Api.new
      cb_response = my_api.cb_get Cb.configuration.uri_saved_search_list, :query => {:developerkey=>developer_key, :ExternalUserId=>external_user_id}
      json_hash = JSON.parse cb_response.response.body
      saved_search = CbSavedSearch.new json_hash['SavedJobSearches']
      my_api.append_api_responses saved_search, json_hash['SavedJobSearches']

      return saved_search
    end

  end
end