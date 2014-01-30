module Cb
  module Clients

    class SavedSearch < ApiRequest

      def initialize
        @list_endpoint = Cb.configuration.uri_saved_search_list
        @show_endpoint = Cb.configuration.uri_saved_search_retrieve
        @create_endpoint = Cb.configuration.uri_saved_search_create
        @update_endpoint = Cb.configuration.uri_saved_search_update
        @delete_endpoint = Cb.configuration.uri_saved_search_delete
        super
      end

      def create(saved_search)
        body = saved_search.create_to_xml
        json = cb_client.cb_post(create_endpoint, :body => body)
        singular_model_response(json, saved_search.external_user_id)
      end

      def update(saved_search)
        body = saved_search.update_to_xml
        json = cb_client.cb_post(update_endpoint, :body => body)
        singular_model_response(json, saved_search.external_user_id, saved_search.external_id)
      end

      def delete(saved_search)
        body = saved_search.delete_to_xml
        json = cb_client.cb_post(delete_endpoint, :body => body)
        Responses::SavedSearch::Delete.new(json)
      end

      def retrieve(external_user_id, external_id, host_site)
        query = retrieve_query(external_user_id, external_id, host_site)
        json = cb_client.cb_get(show_endpoint, :query => query)
        singular_model_response(json, external_user_id, external_id)
      end

      def list(external_user_id, host_site)
        query = list_query(external_user_id, host_site)
        json = cb_client.cb_get(list_endpoint, :query => query)
        Responses::SavedSearch::List.new(json)
      end

      private
      
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

      def singular_model_response(json_hash, external_user_id = nil, external_id = nil)
        json_hash['ExternalUserID'] = external_user_id unless external_user_id.nil?
        json_hash['ExternalID'] = external_id unless external_id.nil?
        Responses::SavedSearch::Singular.new(json_hash)
      end
    end

  end
end
