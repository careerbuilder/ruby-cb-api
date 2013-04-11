require "json"

module Cb
  class CategoryApi
  	def self.search
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_job_category_search)
      json_hash = JSON.parse(cb_response.response.body)

      categoryList = []
      json_hash["ResponseCategories"]["Categories"]["Category"].each do |cat|
        categoryList << CbCategory.new(cat)
      end
      return categoryList
    end

    def self.search_by_host_site(host_site)
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_job_category_search, :query => {:CountryCode => host_site})
      json_hash = JSON.parse(cb_response.response.body)

      categoryList = []
      unless json_hash.empty?
        if json_hash["ResponseCategories"]["Categories"]["Category"].is_a?(Array)
          json_hash["ResponseCategories"]["Categories"]["Category"].each do |cat|
            categoryList << CbCategory.new(cat)
          end
        elsif json_hash["ResponseCategories"]["Categories"]["Category"].is_a?(Hash) && json_hash.length < 2
          categoryList << CbCategory.new(json_hash["ResponseCategories"]["Categories"]["Category"])
        end
      end

      return categoryList
    end
  end  
end
