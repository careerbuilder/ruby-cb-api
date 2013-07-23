require 'nori'

module Cb

	class JobBrandingApi

		def self.find_by_id id
		    my_api = Cb::Utils::Api.new

		    cb_response = my_api.cb_get Cb.configuration.uri_job_branding, :query => { :id => id }

		    xml_hash = Nori.new.parse cb_response.response.body

		    return CbJobBranding.new xml_hash['Branding']
		end

	end

end