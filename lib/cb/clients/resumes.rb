require 'json'

module Cb
  module Clients
    class Resumes
      class << self

        def get_resume_by_hash(criteria)
          response = api_client.cb_get(uri(criteria), query: criteria.to_h)
          Cb::Responses::Resumes::ResumeGet.new(response)
        end

        private
        
        def uri(criteria)
          Cb.configuration.uri_resume_get.gsub(':resume_hash', criteria.resume_hash)
        end

        def api_client
          @api ||= Cb::Utils::Api.instance
        end

      end
    end
  end
end
