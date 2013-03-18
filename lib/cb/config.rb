module Cb
  class Config
    attr_accessor :dev_key, :time_out, :use_json, 
                  :uri_job_search, :uri_job_find,
                  :uri_company_find, :uri_education_code

    def initialize
      set_defaults
    end

    def set_default_api_uris
      @uri_job_search       ||= '/v1/JobSearch'
      @uri_job_find         ||= '/v1/Job'


      @uri_company_find     ||= "/Employer/CompanyDetails"
      @uri_education_code   ||= "/v1/educationcodes"

      @uri_company_find     ||= '/Employer/CompanyDetails'

    end

    def to_hash
      {
        :dev_key              => @dev_key,
        :time_out  	          => @time_out,
        :use_json             => @use_json,
        :uri_job_search       => @uri_job_search,
        :uri_job_find         => @uri_job_find,
        :uri_company_find     => @uri_company_find,
        :uri_education_code  =>  @uri_education_code
      }
    end

    private
    #################################################################

    def set_defaults

      @dev_key              = 'ruby-cb-api'  # Get a developer key at http://api.careerbuilder.com
      @time_out             = 5
      @use_json             = true

      set_default_api_uris
    end
  end
end