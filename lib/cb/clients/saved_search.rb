module Cb
  module Clients

    class SavedSearch
      def create(saved_search)
        body = saved_search.create_to_xml
        json = cb_client.cb_post(Cb.configuration.uri_saved_search_create, :body => body)
        singular_model_response(json, saved_search.external_user_id)
      end

      def update(saved_search)
        body = saved_search.update_to_xml
        json = cb_client.cb_post(Cb.configuration.uri_saved_search_update, :body => body)
        singular_model_response(json, saved_search.external_user_id, saved_search.external_id)
      end

      def delete(saved_search)
        body = saved_search.delete_to_xml
        json = cb_client.cb_post(Cb.configuration.uri_saved_search_delete, :body => body)
        Responses::SavedSearch::Delete.new(json)
      end

      def retrieve(oauth_token, host_site)
        query = retrieve_query(oauth_token)
        json = cb_client.cb_get(Cb.configuration.uri_saved_search_retrieve, :query => query)
        singular_model_response(json, external_user_id, external_id)
      end

      def list(external_user_id, host_site)
        query = list_query(external_user_id, host_site)
        json = cb_client.cb_get(Cb.configuration.uri_saved_search_list, :query => query)
        Responses::SavedSearch::List.new(json)
      end

      private

      def cb_client
        @cb_client ||= Cb.api_client.new
      end

      def retrieve_query(oauth_token, host_site)
        {
          :developerkey   => Cb.configuration.dev_key,
          :useroauthtoken => oauth_token,
          :hostsite => host_site
        }
      end

      def list_query(oauth_token, host_site)
        {
          :developerkey   => Cb.configuration.dev_key,
          :useroauthtoken => oauth_token,
          :hostsite       => host_site
        }
      end

      def singular_model_response(json_hash, external_user_id = nil, external_id = nil)
        json_hash['ExternalUserID'] = external_user_id unless external_user_id.nil?
        json_hash['ExternalID'] = external_id unless external_id.nil?
        Responses::SavedSearch::Singular.new(json_hash)
      end
    end

  end
end
