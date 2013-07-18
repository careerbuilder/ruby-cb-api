require "json"
require "nokogiri"

module Cb
  class SavedJobSearchApi

    def create_saved_search(search)
      my_api = Cb::Utils::Api.new()
      saved_search = my_api.cb_post(Cb.configuration.uri_saved_job_search_create, 
        :body => search.to_xml)
    end

  end
end