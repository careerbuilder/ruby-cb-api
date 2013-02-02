require "HTTParty"

module Cb
	class CbApi
	    include HTTParty
			base_uri "http://api.careerbuilder.com"

		def initialize
			self.class.default_params :developerkey => Cb.configuration.dev_key, 
							   		  :outputjson => Cb.configuration.use_json.to_s
			self.class.default_timeout Cb.configuration.time_out
		end
	end
end