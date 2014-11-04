require 'json'

module Cb
  module Clients
    class LanguageCodes
      class << self
        def codes
          response = api_client.cb_get(Cb.configuration.uri_resume_language_codes)
          Responses::Resumes::LanguageCodes.new(response)
        end

        private
        def api_client
          @api ||= Cb::Utils::Api.instance
        end
      end
    end
  end
end