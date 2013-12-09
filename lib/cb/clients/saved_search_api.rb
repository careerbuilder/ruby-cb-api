require 'json'

module Cb
  module Clients
    class SavedSearchApi

      #############################################################
      ## Create a Saved Search
      ##
      ## For detailed information around this API please visit:
      ## http://api.careerbuilder.com/savedsearchinfo.aspx
      #############################################################
      def self.create *args
        args = args[0] if args.is_a?(Array) && args.count == 1
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_saved_search_create, :body => CbSavedSearch.new(args).create_to_xml

        if json_hash.has_key? 'SavedJobSearch'
          if json_hash['SavedJobSearch'].has_key? 'SavedSearch'
            saved_search = CbSavedSearch.new json_hash['SavedJobSearch']['SavedSearch']
          else
            saved_search = CbSavedSearch.new json_hash['SavedJobSearch']
          end
          my_api.append_api_responses saved_search, json_hash['SavedJobSearch']
        end

        my_api.append_api_responses saved_search, json_hash

        return saved_search
      end

      #############################################################
      ## Update a Saved Search
      ##
      ## For detailed information around this API please visit:
      ## http://api.careerbuilder.com/savedsearchinfo.aspx
      #############################################################
      def self.update *args
        args = args[0] if args.is_a?(Array) && args.count == 1
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_saved_search_update, :body => CbSavedSearch.new(args).update_to_xml

        if json_hash.has_key?('SavedJobSearch')
          saved_search = CbSavedSearch.new json_hash['SavedJobSearch']
          my_api.append_api_responses saved_search, json_hash['SavedJobSearch']
        end

        my_api.append_api_responses saved_search, json_hash

        return saved_search
      end

      #############################################################
      ## Delete a Saved Search
      ##
      ## For detailed information around this API please visit:
      ## http://api.careerbuilder.com/savedsearchinfo.aspx
      #############################################################

      def self.delete *args
        args = args[0] if args.is_a?(Array) && args.count == 1
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_saved_search_delete, :body=>CbSavedSearch.new(args).delete_to_xml

        if json_hash.has_key?('Request')
          saved_search = CbSavedSearch.new json_hash['Request']
          my_api.append_api_responses(saved_search, json_hash['Request'])
        end

        my_api.append_api_responses(saved_search, json_hash)

        return saved_search
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
      ## Developer Key of the owning site for the User is Required*
      ##
      ## For detailed information around this API please visit:
      ## http://api.careerbuilder.com/savedsearchinfo.aspx
      #############################################################
      def self.retrieve developer_key, external_user_id, external_id, host_site
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get Cb.configuration.uri_saved_search_retrieve, :query => {:developerkey=> developer_key, :externaluserid=> external_user_id, :externalid=> external_id, :hostsite=> host_site}

        if json_hash.has_key?('SavedJobSearch')

          if json_hash['SavedJobSearch'].has_key?('SavedSearch')
            saved_search = CbSavedSearch.new json_hash['SavedJobSearch']['SavedSearch']
            my_api.append_api_responses saved_search, json_hash['SavedJobSearch']['SavedSearch']
          end

          my_api.append_api_responses saved_search, json_hash['SavedJobSearch']
        end

        my_api.append_api_responses saved_search, json_hash

        return saved_search
      end

      #############################################################
      ## List of Saved Search's
      ##
      ## For detailed information around this API please visit:
      ## http://api.careerbuilder.com/savedsearchinfo.aspx
      #############################################################
      def self.list developer_key, external_user_id, host_site
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get Cb.configuration.uri_saved_search_list, :query => {:developerkey=>developer_key, :ExternalUserId=>external_user_id, :hostsite=> host_site}
        saved_searches = []
        if json_hash.has_key?('SavedJobSearches') && json_hash['SavedJobSearches'].has_key?('SavedSearches')
          saved_search_hash = json_hash['SavedJobSearches']['SavedSearches']

          unless saved_search_hash.nil?
            if saved_search_hash['SavedSearch'].is_a?(Array)
              saved_search_hash['SavedSearch'].each do |saved_search|
                saved_searches << CbSavedSearch.new(saved_search)
              end
            elsif saved_search_hash['SavedSearch'].is_a?(Hash) && json_hash.length < 2
              saved_searches << CbSavedSearch.new(saved_search_hash['SavedSearch'])
            end
          end

          my_api.append_api_responses saved_searches, json_hash['SavedJobSearches']
        end

        my_api.append_api_responses(saved_searches, json_hash)

        return saved_searches
      end

    end
  end
end
