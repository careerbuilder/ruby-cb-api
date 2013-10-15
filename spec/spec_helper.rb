require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_group 'utils', 'lib/cb/utils'
  add_group 'models', 'lib/cb/models'
  add_group 'clients', 'lib/cb/clients'
  add_group 'criteria', 'lib/cb/criteria'
  add_group 'responses', 'lib/cb/responses'
end

require 'rubygems'
require 'cb'
require 'vcr'
require 'webmock/rspec'
require 'dotenv'
Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir     	= 'spec/cassettes'
  c.hook_into                	:webmock
  c.default_cassette_options 	= { :record => :new_episodes }
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

Cb.configure do |c|
  c.dev_key = ENV['developer_key']
end

# this needs to be uncommented once we're off of vcr!
# WebMock.disable_net_connect!

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

require 'support/convenience'
include Cb::SpecSupport::Convenience
