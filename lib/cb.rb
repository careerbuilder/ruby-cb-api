require 'cb/config'
require 'cb/models/branding/styles/base'
require 'cb/models/branding/styles/css_adapter'
require 'cb/exceptions'

def require_directory(relative_path)
  Dir[File.dirname(__FILE__) + relative_path].each { |file| require file }
end

required_paths = %w(/cb/utils/*.rb /cb/clients/*.rb /cb/criteria/*.rb /cb/models/**/*.rb /cb/responses/**/*.rb)
required_paths.each { |path| require_directory path }

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
    Cb::JobSearchCriteria.new
  end

  def self.job_detail_criteria
    Cb::JobDetailsCriteria.new
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

  def self.resume
    Cb::ResumeApi
  end
  
  def self.application
    Cb::ApplicationApi
  end

  def self.application_external
    Cb::ApplicationExternalApi
  end

  def self.country
    Cb::Utils::Country
  end

  def self.user
    Cb::UserApi
  end

  def self.job_branding
    Cb::JobBrandingApi
  end

  def self.email_subscription
    Cb::EmailSubscriptionApi
  end

  def self.saved_job_search_api
    Cb::SavedJobSearchApi
  end

  def self.saved_search_api
    Cb::SavedSearchApi
  end

  def self.talent_network_api
    Cb::TalentNetworkApi
  end

  def self.anon_saved_search_api
    Cb::AnonSavedSearchApi
  end

  def self.spot
    Cb::ApiClients::Spot
  end
end
