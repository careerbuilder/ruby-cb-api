require 'simplecov'
require 'codeclimate-test-reporter'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
]
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
  c.mock_with :rspec do |mocks|
    mocks.yield_receiver_to_any_instance_implementation_blocks = true
  end
end

require 'support/convenience'
include Cb::SpecSupport::Convenience
