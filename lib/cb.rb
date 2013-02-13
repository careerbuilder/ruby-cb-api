require "cb/cb_api"
require "cb/cb_job"
require "cb/cb_job_api"
require "cb/cb_company"
require "cb/cb_company_api"
require "cb/config"
require "fluid_attributes"
require "cb/job_search_criteria"

module Cb
	def self.configure
		yield configuration
	end

	def self.configuration
		@configuration ||= Cb::Config.new
		@configuration.set_default_api_uris

		return @configuration
	end
end