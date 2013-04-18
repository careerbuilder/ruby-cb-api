# require 'cb/config'
# require 'cb/utils/api'
# require 'cb/utils/meta_values'
# require 'cb/utils/country'
# require 'cb/utils/fluid_attributes'
# require 'cb/cb_job'
# require 'cb/job_api'
# require 'cb/job_search_criteria'
# require 'cb/recommendation_api'
# require 'cb/cb_company'
# require 'cb/company_api'
# require 'cb/cb_category'
# require 'cb/category_api'
# require 'cb/cb_employee_type'
# require 'cb/employee_types_api'
# require 'cb/cb_education'
# require 'cb/education_api'
# require 'cb/job_application_api'
# require 'cb/cb_job_application'

require 'cb/config'
Dir[File.dirname(__FILE__) + '/cb/utils/*.rb'].each {| file| require file }
Dir[File.dirname(__FILE__) + '/cb/clients/*.rb'].each {| file| require file }
Dir[File.dirname(__FILE__) + '/cb/models/*.rb'].each {| file| require file }

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
  
  def self.job_application
    Cb::JobApplicationApi
  end

  def self.country
    Cb::Utils::Country
  end
end