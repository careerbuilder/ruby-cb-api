require 'json'

module Cb
  module Clients
    class Resumes
      class << self

        def get_resume_by_hash(args)
          response = api_client.cb_get(Cb.configuration.uri_resume_get, query: args)
          Cb::Responses::Resumes::ResumeGet.new(response)
        end

        def api_client
          @api ||= Cb::Utils::Api.instance
        end

      end
    end
  end
end
