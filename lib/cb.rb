# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'cb/config'
require 'cb/models/implementations/branding/styles/base'
require 'cb/models/implementations/branding/styles/css_adapter'
require 'cb/exceptions'
require 'cb/convenience'
require 'cb/client'
require 'middleware/errors'
require 'middleware/timing'
require 'middleware/developerkey'
require 'middleware/default_response'

def require_directory(relative_path)
  Dir[File.dirname(__FILE__) + relative_path].each { |file| require file }
end

%w(/cb/utils/*.rb /cb/clients/**/*.rb /cb/criteria/**/*.rb /cb/models/**.rb
   /cb/models/**/*.rb /cb/responses/*.rb /cb/responses/**/*.rb
   /cb/requests/*.rb /cb/requests/**/*.rb).each { |path| require_directory path }

module Cb
  extend Convenience::ClassMethods

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Cb::Config.new
    @configuration
  end

  Faraday::Response.register_middleware cb_errors: Middleware::Errors
  Faraday::Response.register_middleware default_response: Middleware::DefaultResponse
  Faraday::Request.register_middleware cb_devkey: Middleware::Developerkey
end
