require "json"

module Cb
  module Clients
    class Industry
      class << self

        def search
          response = api_client.cb_get(Cb.configuration.uri_job_industry_search)
          Cb::Responses::Industry::Search.new(response)
        end

        def search_by_host_site(host_site)
          response = api_client.cb_get(Cb.configuration.uri_job_industry_search, :query => {:CountryCode => host_site})
          Cb::Responses::Industry::Search.new(response)
        end

        private

        def api_client
          @api ||= Cb::Utils::Api.instance
        end
      end
    end
  end
end
