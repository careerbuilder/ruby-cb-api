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
require 'json'
require_relative 'base'
module Cb
  module Clients
    class Category < Base
      def self.search
        json_hash = cb_client.cb_get(Cb.configuration.uri_job_category_search)
        categoryList = []

        if json_hash.key?('ResponseCategories')
          if json_hash['ResponseCategories'].key?('Categories')
            json_hash['ResponseCategories']['Categories']['Category'].each do |cat|
              categoryList << Models::Category.new(cat)
            end
          end

          cb_client.append_api_responses(categoryList, json_hash['ResponseCategories'])
        end

        cb_client.append_api_responses(categoryList, json_hash)
      end

      def self.search_by_host_site(host_site)
        json_hash = cb_client.cb_get(Cb.configuration.uri_job_category_search, query: { CountryCode: host_site })
        categoryList = []

        if json_hash.key?('ResponseCategories')
          if json_hash['ResponseCategories'].key?('Categories')
            if json_hash['ResponseCategories']['Categories']['Category'].is_a?(Array)
              json_hash['ResponseCategories']['Categories']['Category'].each do |cat|
                categoryList << Models::Category.new(cat)
              end
            elsif json_hash['ResponseCategories']['Categories']['Category'].is_a?(Hash) && json_hash.length < 2
              categoryList << Models::Category.new(json_hash['ResponseCategories']['Categories']['Category'])
            end
          end

          cb_client.append_api_responses(categoryList, json_hash['ResponseCategories'])
        end

        cb_client.append_api_responses(categoryList, json_hash)
      end
    end
  end
end
