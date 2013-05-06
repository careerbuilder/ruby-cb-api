module Cb
  class Config
    attr_accessor :dev_key, :time_out, :use_json, :host_site,
                  :uri_job_search, :uri_job_find,
                  :uri_company_find, :uri_job_category_search,
                  :uri_education_code, :uri_employee_types,
                  :uri_recommendation_for_job, :uri_recommendation_for_user,
                  :uri_recommendation_for_company,
                  :uri_application, :uri_application_submit,
                  :uri_application_registered, :job_did

    def initialize
      Cb::Utils::Country.inject_convenience_methods
      set_defaults
    end

    def set_default_api_uris
      @uri_job_category_search            ||= '/v1/categories'
      @uri_employee_types                 ||= '/v1/employeetypes'
      @uri_company_find                   ||= '/Employer/CompanyDetails'
      @uri_job_search                     ||= '/v1/JobSearch'
      @uri_job_find                       ||= '/v1/Job'
      @uri_education_code                 ||= '/v1/EducationCodes'
      @uri_recommendation_for_job         ||= '/v1/Recommendations/ForJob'
      @uri_recommendation_for_user        ||= '/v1/Recommendations/ForUser'
      @uri_recommendation_for_company     ||= '/Employer/JobRecommendation'
      @uri_application                    ||= '/v1/application/blank'
      @uri_application_submit             ||= '/v1/Application/submit'
      @uri_application_registered         ||= '/v3/Application/registered'
    end

    def to_hash
      {
        :uri_job_category_search          => @uri_job_category_search,
        :uri_employee_types               => @uri_employee_types,
        :dev_key                          => @dev_key,
        :host_site                        => @host_site,
        :time_out  	                      => @time_out,
        :use_json                         => @use_json,
        :uri_job_search                   => @uri_job_search,
        :uri_job_find                     => @uri_job_find,
        :uri_company_find                 => @uri_company_find,
        :uri_education_code               => @uri_education_code,
        :uri_recommendation_for_job       => @uri_recommendation_for_job,
        :uri_recommendation_for_user      => @uri_recommendation_for_user,
        :uri_recommendation_for_company   => @uri_recommendation_for_company,
        :uri_application                  => @uri_application,
        :uri_application_submit           => @uri_application_submit,
        :uri_application_registered       => @uri_application_registered,
        :job_did                          => @job_did
      }
    end

    private
    #################################################################

    def set_defaults

      @dev_key              = 'ruby-cb-api'  # Get a developer key at http://api.careerbuilder.com
      @time_out             = 5
      @use_json             = true
      @host_site            = Cb.country.US

      set_default_api_uris
    end
  end
end