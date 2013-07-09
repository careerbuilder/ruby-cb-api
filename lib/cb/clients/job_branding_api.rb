require 'active_support/core_ext/hash/conversions' # For from_xml on Hash

module Cb

	class JobBrandingApi

		def self.find_by_id id
		    my_api = Cb::Utils::Api.new

		    cb_response = my_api.cb_get Cb.configuration.uri_job_branding, :query => { :id => id }

		    json_hash = Hash.from_xml cb_response.response.body

		    return CbJobBranding.new json_hash['Branding']
		end

	end

end