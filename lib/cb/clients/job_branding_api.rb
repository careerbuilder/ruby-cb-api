require 'nori'

module Cb

	class JobBrandingApi

		def self.find_by_id id
		  my_api = Cb::Utils::Api.new

		  json_hash = my_api.cb_get Cb.configuration.uri_job_branding, :query => { :id => id }

      if json_hash.has_key? 'Branding'
        branding = CbJobBranding.new json_hash['Branding']
        my_api.append_api_responses(branding, json_hash['Branding'])
      end

      my_api.append_api_responses(branding, json_hash)

		  return branding
		end

	end

end