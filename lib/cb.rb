<<<<<<< HEAD
require "cb/cb_api"
require "cb/cb_job"
require "cb/cb_job_api"
require "cb/cb_company"
require "cb/cb_company_api"
require "cb/cb_education_code"
require "cb/cb_education_code_api"
require "cb/config"
require "fluid_attributes"
require "cb/job_search_criteria"
=======
require 'cb/config'
require 'cb/utils/api'
require 'cb/utils/meta_values'
require 'fluid_attributes'
require 'cb/cb_job'
require 'cb/job_api'
require 'cb/job_search_criteria'
require 'cb/cb_company'
require 'cb/company_api'
>>>>>>> 8f3d1e0e9a7c5b75a7a338269615c5bae7c9d734

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

  def self.job_search_criteria
    Cb::JobSearchCriteria.new()
  end

  def self.company
    Cb::CompanyApi
  end
end