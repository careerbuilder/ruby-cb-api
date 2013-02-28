require 'cb/config'
require 'cb/utils/api'
require 'cb/utils/meta_values'
require 'fluid_attributes'
require 'cb/cb_job'
require 'cb/job_api'
require 'cb/job_search_criteria'
require 'cb/cb_company'
require 'cb/company_api'

module Cb
	def self.configure
		yield configuration
	end

  def self.configuration
    @configuration ||= Cb::Config.new
    @configuration.set_default_api_uris

    return @configuration
  end

  # Convenience methods, in case you're lazy... like me :)
  ###############################################################
  def self.job
    Cb::JobApi
  end

  def self.company
    Cb::CompanyApi
  end
end