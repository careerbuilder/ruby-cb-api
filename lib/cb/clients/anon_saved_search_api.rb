module Cb
  class AnonSavedSearchApi
    def self.create *args
      args = args[0] if args.is_a?(Array) && args.count == 1
      my_api = Cb::Utils::Api.new

      json_hash = my_api.cb_post Cb.configuration.uri_anon_saved_search_create, :body => CbSavedSearch.new(args).create_to_xml

      if json_hash.has_key? 'AnonymousSavedSearch'
        json_hash['AnonymousSavedSearch']['ExternalID'] = json_hash['ExternalID']
      end

      if json_hash.has_key?('Errors') && json_hash['Errors'].size < 1
        saved_search = CbSavedSearch.new(json_hash['AnonymousSavedSearch'])
      else
        saved_search = CbSavedSearch.new(json_hash)
      end

      my_api.append_api_responses(saved_search, json_hash)

      return saved_search
    end

    def self.delete *args
      args = args[0] if args.is_a?(Array) && args.count == 1
      my_api = Cb::Utils::Api.new

      json_hash = my_api.cb_post Cb.configuration.uri_anon_saved_search_delete, :body => CbSavedSearch.new(args).delete_anon_to_xml

      if json_hash.has_key?('Errors') && json_hash['Errors'].size < 1
        response = json_hash['Status']
      else
        response = json_hash['Errors']
      end

      my_api.append_api_responses(response, json_hash)

      return response
    end
  end
end