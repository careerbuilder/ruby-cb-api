require 'rubygems'
require 'simplecov'
require 'cb'
require 'webmock/rspec'

SimpleCov.start do
  add_filter '/spec/'
end

WebMock.disable_net_connect!

RSpec.configure do | c |
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

require 'support/convenience'
include Cb::SpecSupport::Convenience
