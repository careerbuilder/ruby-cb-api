require 'HTTParty'
                                                                      1
module Cb
	class CbApi
	    include HTTParty
			base_uri 'http://api.careerbuilder.com'
			#debug_output $stderr
		attr_accessor :errors, :time_elapsed, :time_sent

		def initialize
			self.class.default_params :developerkey => Cb.configuration.dev_key, 
							   		            :outputjson => Cb.configuration.use_json.to_s
							   		  
			self.class.default_timeout Cb.configuration.time_out
		end

		def self.api_get(*args, &block)
			self.class.default_params :developerkey => Cb.configuration.dev_key, 
							   		            :outputjson => Cb.configuration.use_json.to_s
			self.class.default_timeout Cb.configuration.time_out


			response = self.class.get(*args, &block)

			return response
		end

		private
		#############################################################################

		def populate_from(response, node = '')
      		@errors 		= response[node]['Errors'] || ''
      		@time_elapsed	= response[node]['TimeResponseSent'] || ''
      		@time_sent		= response[node]['TimeElapsed'] || ''
		end
	end
end