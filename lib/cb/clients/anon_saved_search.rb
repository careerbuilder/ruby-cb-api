module Cb
  module Clients

    class AnonSavedSearch
      def create(*args)
        body = new_model(*args).create_anon_to_xml
        json = cb_client.cb_post(create_uri, :body => body)
        Responses::AnonymousSavedSearch::Create.new(json)
      end

      def delete(*args)
        body = new_model(*args).delete_anon_to_xml
        json = cb_client.cb_post(delete_uri, :body => body)
        Responses::AnonymousSavedSearch::Delete.new(json)
      end

      private

      def new_model(*args)
        Models::SavedSearch.new(extract_args(*args))
      end

      def extract_args(*args)
        args.is_a?(Array) && args.count == 1 ? args[0] : args
      end

      def create_uri
        Cb.configuration.uri_anon_saved_search_create
      end

      def delete_uri
        Cb.configuration.uri_anon_saved_search_delete
      end

      def cb_client
        @cb_client ||= Cb.api_client.new
      end
    end

  end
end
