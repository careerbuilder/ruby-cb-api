module Cb
  class AnonSavedSearchApi
    def self.create *args
      args = args[0] if args.is_a?(Array) && args.count == 1
      my_api = Cb::Utils::Api.new

      cb_response = my_api.cb_post Cb.configuration.uri_anon_saved_search_create, :body => CbSavedSearch.new(args).create_to_xml

      json_hash = JSON.parse(cb_response.response.body)

      if json_hash['Errors'].size < 1
        saved_search = CbSavedSearch.new(json_hash['AnonymousSavedSearch'])
      else
        saved_search = CbSavedSearch.new(json_hash)
      end

      return saved_search

    end
  end
end