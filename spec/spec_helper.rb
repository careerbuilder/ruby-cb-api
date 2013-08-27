require 'rubygems'
require 'simplecov'

SimpleCov.start do
	add_filter '/spec/'
end

require 'cb'

Cb.configure do | config |
	config.use_json 	= true                    ########################################################
	config.dev_key  	= 'WDHH6P96RQD9FSDCZ0G7'  # CB Ruby API key for unit tests
	config.time_out 	= 5						            # Register for your own key at http://api.careerbuilder.com/
end

require 'vcr'
require 'webmock'

VCR.configure do | c |
  c.cassette_library_dir     	= 'spec/cassettes'
  c.hook_into                	:webmock
  c.default_cassette_options 	= { :record => :new_episodes }
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do | c |
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
