# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require_relative 'base'
module Cb
  module Clients
    class SavedSearch < Base
      def self.create(saved_search)
        body = saved_search.create_to_xml
        json = cb_client.cb_post(Cb.configuration.uri_saved_search_create, body: body)
        singular_model_response(json, saved_search.external_user_id)
      end

      def self.update(saved_search)
        body = saved_search.update_to_json
        json = cb_client.cb_put(Cb.configuration.uri_saved_search_update, body: body, headers: update_headers(saved_search.host_site))
        Responses::SavedSearch::Update.new(json)
      end

      def self.delete(hash)
        uri = replace_uri_field(Cb.configuration.uri_saved_search_delete, ':did', hash[:did])
        json = cb_client.cb_delete(
          uri,
          headers: { 'HostSite' => hash[:host_site] },
          query: { 'UserOAuthToken' => hash[:user_oauth_token] }
        )
        Responses::SavedSearch::Delete.new(json)
      end

      def self.retrieve(oauth_token, external_id)
        query = retrieve_query(oauth_token)
        uri = replace_uri_field(Cb.configuration.uri_saved_search_retrieve, ':did', external_id)
        json = cb_client.cb_get(uri, query: query)
        Responses::SavedSearch::Retrieve.new(json)
      end

      def self.list(oauth_token, hostsite)
        query = list_query(oauth_token, hostsite)
        json = cb_client.cb_get(Cb.configuration.uri_saved_search_list, query: query)
        Responses::SavedSearch::List.new(json)
      end

      private

      def self.update_headers(host_site)
        {
          'developerkey' => Cb.configuration.dev_key,
          'Content-Type' => 'application/json',
          'HostSite' => (host_site.empty? ? Cb.configuration.host_site : host_site)
        }
      end

      def self.retrieve_query(oauth_token)
        {
          developerkey: Cb.configuration.dev_key,
          useroauthtoken: oauth_token
        }
      end

      def self.list_query(oauth_token, hostsite)
        {
          developerkey: Cb.configuration.dev_key,
          useroauthtoken: oauth_token,
          hostsite: hostsite
        }
      end

      def self.singular_model_response(json_hash, external_user_id = nil, external_id = nil)
        json_hash['ExternalUserID'] = external_user_id unless external_user_id.nil?
        json_hash['ExternalID'] = external_id unless external_id.nil?
        Responses::SavedSearch::Singular.new(json_hash)
      end

      def self.replace_uri_field(uri_string, field, replacement)
        uri_string.gsub(field, replacement)
      end
    end
  end
end
