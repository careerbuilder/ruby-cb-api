require 'json'

module Cb
  module Clients
    class Resumes
      class << self

        def get_resume_by_hash(args)
          uri = Cb.configuration.uri_resume_get.gsub(':resume_hash', args[:resume_hash])
          query = get_query(args)
          response = api_client.cb_get(uri, query: query)
          Cb::Responses::Resumes::ResumeGet.new(response)
        end

        def api_client
          @api ||= Cb::Utils::Api.instance
        end

        private

        def get_query(args)
          {
              :externalUserID => args[:externalUserID]
          }
        end

      end
    end
  end
end
