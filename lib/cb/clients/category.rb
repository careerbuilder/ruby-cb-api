require "json"

module Cb
  module Clients
    class Category

      def self.search
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get(Cb.configuration.uri_job_category_search)
        categoryList = []

        if json_hash.has_key?('ResponseCategories')
          if json_hash['ResponseCategories'].has_key?('Categories')
            json_hash['ResponseCategories']['Categories']['Category'].each do |cat|
              categoryList << Models::Category.new(cat)
            end
          end

          my_api.append_api_responses(categoryList, json_hash['ResponseCategories']).to_json
        end

        my_api.append_api_responses(categoryList, json_hash).to_json
      end

      def self.search_by_host_site(host_site)
        my_api = Cb::Utils::Api.instance
        json_hash = my_api.cb_get(Cb.configuration.uri_job_category_search, :query => {:CountryCode => host_site})
        categoryList = []

        if json_hash.has_key?('ResponseCategories')
          if json_hash['ResponseCategories'].has_key?('Categories')
            if json_hash['ResponseCategories']['Categories']['Category'].is_a?(Array)
              json_hash['ResponseCategories']['Categories']['Category'].each do |cat|
                categoryList << Models::Category.new(cat)
              end
            elsif json_hash['ResponseCategories']['Categories']['Category'].is_a?(Hash) && json_hash.length < 2
              categoryList << Models::Category.new(json_hash['ResponseCategories']['Categories']['Category'])
            end
          end

          my_api.append_api_responses(categoryList, json_hash['ResponseCategories']).to_json
        end

        my_api.append_api_responses(categoryList, json_hash).to_json
      end

    end
  end
end
