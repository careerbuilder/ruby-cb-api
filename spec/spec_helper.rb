require 'rubygems'
require 'simplecov'
SimpleCov.start do
end

require 'cb'

Cb.configure do |config|
	config.use_json = true			 		 ############################################################
	config.dev_key = "WDhd88S735S3V2NWZKPD"  #"WDHH6P96RQD9FSDCZ0G7" # CB Ruby API key for unit tests
	config.time_out = 5					 	 # Register for your own key at http://api.careerbuilder.com/
end