require "HTTParty"

module Cb
	class CbApi
	    include HTTParty
			base_uri "http://api.careerbuilder.com"
		attr_accessor :errors, :time_elapsed, :time_sent

		def initialize
			self.class.default_params :developerkey => Cb.configuration.dev_key, 
							   		  :outputjson => Cb.configuration.use_json.to_s
							   		  
			self.class.default_timeout Cb.configuration.time_out
		end

		def self.api_get(*args, &block)
		  response = self.get(*args, &block)
		  populate_from response

		  return response
		end

		private
		#############################################################################

		def self.populate_from(response)
      		@errors 		= response["Errors"] || ""
      		@time_elapsed	= response["TimeResponseSent"] || ""
      		@time_sent		= response["TimeElapsed"] || ""
		end
	end
end