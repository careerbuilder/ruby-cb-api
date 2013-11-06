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
require 'webmock/rspec'
require 'pry'

WebMock.disable_net_connect!

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

require 'support/convenience'
include Cb::SpecSupport::Convenience
