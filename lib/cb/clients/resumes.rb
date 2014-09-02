require 'json'

module Cb
  module Clients
    class Resumes
      class << self
        attr_reader :api_args

        def get_resume_by_hash(args)
          @api_args = args
          Cb::Responses::Resumes::ResumeGet.new(get_resume_by_hash_response)
        end

        private

        def get_resume_by_hash_response
          api_client.cb_get(uri, query: query)
        end
        
        def uri
          Cb.configuration.uri_resume_get.gsub(':resume_hash', @api_args[:resume_hash])
        end

        def query
          { :externalUserID => @api_args[:externalUserID] }
        end

        def api_client
          @api ||= Cb::Utils::Api.instance
        end

      end
    end
  end
end
