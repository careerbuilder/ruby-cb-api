require "HTTParty"

module Cb
	class CbApi
	    include HTTParty
			base_uri "http://api.careerbuilder.com"
			#default_params :developerkey => Cb.configuration.dev_key
			#			    :outputjson => InternalApiGem::configuration.use_json.to_s
			#default_timeout InternalApiGem::configuration.api_time_out
	end
end