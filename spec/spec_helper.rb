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
  c.mock_with :rspec do |mocks|
    # In RSpec 3, `any_instance` implementation blocks will be yielded the receiving
    # instance as the first block argument to allow the implementation block to use
    # the state of the receiver.
    # In RSpec 2.99, to maintain compatibility with RSpec 3 you need to either set
    # this config option to `false` OR set this to `true` and update your
    # `any_instance` implementation blocks to account for the first block argument
    # being the receiving instance.
    mocks.yield_receiver_to_any_instance_implementation_blocks = true
  end
end

require 'support/convenience'
include Cb::SpecSupport::Convenience
