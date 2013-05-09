require 'cb/config'
Dir[File.dirname(__FILE__) + '/cb/utils/*.rb'].each {| file| require file }
Dir[File.dirname(__FILE__) + '/cb/clients/*.rb'].each {| file| require file }
Dir[File.dirname(__FILE__) + '/cb/models/*.rb'].each {| file| require file }
require 'cb/job_search_criteria'

module Cb::Utils
end

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

  def self.job_detail_criteria
    Cb::JobApi::DetailsCriteria.new()
  end

  def self.category
    Cb::CategoryApi
  end

  def self.company
    Cb::CompanyApi
  end

  def self.education_code
    Cb::EducationApi
  end

  def self.recommendation
    Cb::RecommendationApi
  end
  
  def self.application
    Cb::ApplicationApi
  end

  def self.country
    Cb::Utils::Country
  end
end