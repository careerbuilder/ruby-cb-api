require 'json'

module Cb
  module Clients
    class Resumes
      class << self

        def get_resume_by_hash(args)
          uri = Cb.configuration.uri_resume_get.gsub(':resume_hash', args[:resume_hash])
          query = get_query(args)
          binding.pry
          response = api_client.cb_get(uri, query: query)
          binding.pry
          Cb::Responses::Resumes::ResumeGet.new(response)
        end

        def api_client
          @api ||= Cb::Utils::Api.instance
        end

        private

        def get_query(args)
          {
              :externalUserID => args[:externalUserID],
              :developerKey => Cb.configuration.dev_key
          }
        end

      end
    end
  end
end
