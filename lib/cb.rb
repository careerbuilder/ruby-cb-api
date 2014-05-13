require 'cb/config'
require 'cb/models/implementations/branding/styles/base'
require 'cb/models/implementations/branding/styles/css_adapter'
require 'cb/exceptions'
require 'cb/convenience'
require 'cb/client'

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
    @configuration.set_default_api_uris
    @configuration
  end
end
