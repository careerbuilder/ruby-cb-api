# Copyright 2016 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'simplecov'
require 'codeclimate-test-reporter'
SimpleCov.start do
  add_filter '/spec/'
  add_group 'utils', 'lib/cb/utils'
  add_group 'models', 'lib/cb/models'
  add_group 'clients', 'lib/cb/clients'
  add_group 'criteria', 'lib/cb/criteria'
  add_group 'responses', 'lib/cb/responses'
  formatter SimpleCov::Formatter::MultiFormatter[
                SimpleCov::Formatter::HTMLFormatter,
                CodeClimate::TestReporter::Formatter
            ]
end

require 'rubygems'
require 'cb'
require 'webmock/rspec'
require 'pry'

WebMock.disable_net_connect!(allow: 'codeclimate.com')

RSpec.configure do |c|
  c.mock_with :rspec do |mocks|
    mocks.yield_receiver_to_any_instance_implementation_blocks = true
  end
end

require 'support/convenience'
include Cb::SpecSupport::Convenience

require 'support/rspec/matchers/be_a_subclass_of'
