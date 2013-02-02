require 'rubygems'
require 'simplecov'
SimpleCov.start do
end

require 'cb'

Cb.configure do |config|
	config.use_json = true			 ############################################################
	dev_key = "WDHH6P96RQD9FSDCZ0G7" # CB Ruby API key for unit tests
	time_out = 5					 # Register for your own key at http://api.careerbuilder.com/
end