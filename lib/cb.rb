require 'cb/config'
require 'cb/models/implementations/branding/styles/base'
require 'cb/models/implementations/branding/styles/css_adapter'
require 'cb/exceptions'

def require_directory(relative_path)
  Dir[File.dirname(__FILE__) + relative_path].each { |file| require file }
end

required_paths = %w(/cb/utils/*.rb /cb/clients/*.rb /cb/criteria/*.rb /cb/models/*.rb
                    /cb/models/**/*.rb /cb/responses/*.rb /cb/responses/**/*.rb)
required_paths.each { |path| require_directory path }

module Cb
	def self.configure
		yield configuration
	end

  def self.configuration
    @configuration ||= Cb::Config.new
    @configuration.set_default_api_uris
    @configuration
  end

  # Convenience methods, in case you're lazy... like me :)
  ###############################################################

  #Cb::JobApi
  def self.job
    Cb::JobApi
  end

  #Cb::JobSearchCriteria
  def self.job_search_criteria
    Cb::JobSearchCriteria.new
  end

  #Cb::JobDetailsCriteria
  def self.job_detail_criteria
    Cb::JobDetailsCriteria.new
  end

  #Cb::CategoryApi
  def self.category
    Cb::CategoryApi
  end

  #Cb::CompanyApi
  def self.company
    Cb::CompanyApi
  end

  #Cb::EducationApi
  def self.education_code
    Cb::EducationApi
  end

  #Cb::RecommendationApi
  def self.recommendation
    Cb::RecommendationApi
  end

  #Cb::ResumeApi
  def self.resume
    Cb::ResumeApi
  end

  #Cb::ApplicationApi
  def self.application
    Cb::ApplicationApi
  end

  #Cb::ApplicationExternalApi
  def self.application_external
    Cb::ApplicationExternalApi
  end

  #Cb::Utils::Country
  def self.country
    Cb::Utils::Country
  end

  #Cb::UserApi
  def self.user
    Cb::UserApi
  end

  #Cb::JobBrandingApi
  def self.job_branding
    Cb::JobBrandingApi
  end

  #Cb::EmailSubscriptionApi
  def self.email_subscription
    Cb::EmailSubscriptionApi
  end

  #Cb::SavedSearchApi
  def self.saved_search_api
    Cb::SavedSearchApi
  end

  #Cb::TalentNetworkApi
  def self.talent_network_api
    Cb::TalentNetworkApi
  end

  #Cb::AnonSavedSearchApi
  def self.anon_saved_search_api
    Cb::AnonSavedSearchApi
  end

  #Cb::ApiClients::Spot
  def self.spot
    Cb::ApiClients::Spot
  end
end
