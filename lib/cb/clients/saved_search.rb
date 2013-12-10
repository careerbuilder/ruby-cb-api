require 'json'

module Cb
  module Clients
    class SavedSearch

      def self.create *args
        args = args[0] if args.is_a?(Array) && args.count == 1
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_saved_search_create, :body => Models::SavedSearch.new(args).create_to_xml

        if json_hash.has_key? 'SavedJobSearch'
          if json_hash['SavedJobSearch'].has_key? 'SavedSearch'
            saved_search = Models::SavedSearch.new json_hash['SavedJobSearch']['SavedSearch']
          else
            saved_search = Models::SavedSearch.new json_hash['SavedJobSearch']
          end
          my_api.append_api_responses saved_search, json_hash['SavedJobSearch']
        end

        my_api.append_api_responses saved_search, json_hash
      end

      def self.update *args
        args = args[0] if args.is_a?(Array) && args.count == 1
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_saved_search_update, :body => Models::SavedSearch.new(args).update_to_xml

        if json_hash.has_key?('SavedJobSearch')
          saved_search = Models::SavedSearch.new json_hash['SavedJobSearch']
          my_api.append_api_responses saved_search, json_hash['SavedJobSearch']
        end

        my_api.append_api_responses saved_search, json_hash
      end

      def self.delete *args
        args = args[0] if args.is_a?(Array) && args.count == 1
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post Cb.configuration.uri_saved_search_delete, :body => Models::SavedSearch.new(args).delete_to_xml

        if json_hash.has_key?('Request')
          saved_search = Models::SavedSearch.new json_hash['Request']
          my_api.append_api_responses(saved_search, json_hash['Request'])
        end

        my_api.append_api_responses(saved_search, json_hash)
      end

      def self.retrieve developer_key, external_user_id, external_id, host_site
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get Cb.configuration.uri_saved_search_retrieve, :query => {:developerkey=> developer_key, :externaluserid=> external_user_id, :externalid=> external_id, :hostsite=> host_site}

        if json_hash.has_key?('SavedJobSearch')
          if json_hash['SavedJobSearch'].has_key?('SavedSearch')
            saved_search = Models::SavedSearch.new json_hash['SavedJobSearch']['SavedSearch']
            my_api.append_api_responses saved_search, json_hash['SavedJobSearch']['SavedSearch']
          end
          my_api.append_api_responses saved_search, json_hash['SavedJobSearch']
        end
        my_api.append_api_responses saved_search, json_hash
      end

      def self.list developer_key, external_user_id, host_site
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get Cb.configuration.uri_saved_search_list, :query => {:developerkey=>developer_key, :ExternalUserId=>external_user_id, :hostsite=> host_site}
        saved_searches = []
        if json_hash.has_key?('SavedJobSearches') && json_hash['SavedJobSearches'].has_key?('SavedSearches')
          saved_search_hash = json_hash['SavedJobSearches']['SavedSearches']

          unless saved_search_hash.nil?
            if saved_search_hash['SavedSearch'].is_a?(Array)
              saved_search_hash['SavedSearch'].each do |saved_search|
                saved_searches << Models::SavedSearch.new(saved_search)
              end
            elsif saved_search_hash['SavedSearch'].is_a?(Hash) && json_hash.length < 2
              saved_searches << Models::SavedSearch.new(saved_search_hash['SavedSearch'])
            end
          end

          my_api.append_api_responses saved_searches, json_hash['SavedJobSearches']
        end

        my_api.append_api_responses(saved_searches, json_hash)
      end

    end
  end
end
