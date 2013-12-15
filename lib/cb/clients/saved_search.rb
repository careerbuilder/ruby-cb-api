module Cb
  module Clients

    class SavedSearch
      def create(saved_search_model)
        body = saved_search_model.create_to_xml
        json = cb_client.cb_post(Cb.configuration.uri_saved_search_create, :body => body)
        Responses::SavedSearch::Retrieve.new(json)
      end

      def update(saved_search_model)
        body = saved_search_model.update_to_xml
        json = cb_client.cb_post(Cb.configuration.uri_saved_search_update, :body => body)
        Responses::SavedSearch::Update.new(json)
      end

      def delete(saved_search_model)
        body = saved_search_model.delete_to_xml
        json = cb_client.cb_post(Cb.configuration.uri_saved_search_delete, :body => body)
        Responses::SavedSearch::Delete.new(json)
      end

      def retrieve(external_user_id, external_id, host_site)
        query = retrieve_query(external_user_id, external_id, host_site)
        json = cb_client.cb_get(Cb.configuration.uri_saved_search_retrieve, :query => query)
        json['ExternalUserID'] = external_user_id
        Responses::SavedSearch::Retrieve.new(json)
      end

      def list(external_user_id, host_site)
        query = list_query(external_user_id, host_site)
        json = cb_client.cb_get(Cb.configuration.uri_saved_search_list, :query => query)
        json['ExternalUserID'] = external_user_id
        Responses::SavedSearch::List.new(json)
      end

      private

      def cb_client
        @cb_client ||= Cb.api_client.new
      end

      def retrieve_query(external_user_id, external_id, host_site)
        {
          :developerkey   => Cb.configuration.dev_key,
          :externalid     => external_id,
          :externaluserid => external_user_id,
          :hostsite       => host_site
        }
      end

      def list_query(external_user_id, host_site)
        {
          :developerkey   => Cb.configuration.dev_key,
          :externaluserid => external_user_id,
          :hostsite       => host_site
        }
      end
    end

  end
end
