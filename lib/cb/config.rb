module Cb
  class Config
    attr_accessor :dev_key, :base_uri, :debug_api, :time_out, :use_json, :host_site, :test_mode,
                  :uri_job_search, :uri_job_find,
                  :uri_company_find, :uri_job_category_search,
                  :uri_education_code, :uri_employee_types,
                  :uri_recommendation_for_job, :uri_recommendation_for_user,
                  :uri_recommendation_for_company,
                  :uri_application, :uri_application_submit,
                  :uri_application_external,
                  :uri_application_registered, :uri_user_change_password,
                  :uri_user_delete, :uri_user_retrieve, :uri_user_check_existing,
                  :uri_job_branding,
                  :uri_resume_own_all, :uri_resume_retrieve,
                  :uri_resume_create, :uri_resume_update, :uri_resume_delete,
                  :uri_saved_search_retrieve, :uri_saved_search_create, :uri_saved_search_update, :uri_saved_search_list, :uri_saved_search_delete,
                  :uri_anon_saved_search_create, :uri_anon_saved_search_delete,
                  :uri_saved_job_search_create,
                  :uri_job_branding, :uri_tn_join_questions, :uri_tn_job_info, :uri_tn_join_form_geo,
                  :uri_tn_join_form_branding, :uri_tn_member_create,
                  :uri_subscription_retrieve, :uri_subscription_modify,
                  :uri_spot_retrieve

    def initialize
      Cb::Utils::Country.inject_convenience_methods
      set_defaults
    end

    def set_default_api_uris
      @uri_job_category_search            ||= '/v1/categories'
      @uri_employee_types                 ||= '/v1/employeetypes'
      @uri_company_find                   ||= '/Employer/CompanyDetails'
      @uri_job_search                     ||= '/v1/JobSearch'
      @uri_job_find                       ||= '/v3/Job'
      @uri_education_code                 ||= '/v1/EducationCodes'
      @uri_recommendation_for_job         ||= '/v1/Recommendations/ForJob'
      @uri_recommendation_for_user        ||= '/v1/Recommendations/ForUser'
      @uri_recommendation_for_company     ||= '/Employer/JobRecommendation'
      @uri_application                    ||= '/cbapi/application/:did'
      @uri_application_submit             ||= '/v1/Application/submit'
      @uri_application_registered         ||= '/v3/application/registered'
      @uri_application_external           ||= '/v1/application/external'
      @uri_user_change_password           ||= '/v2/User/ChangePW'
      @uri_user_delete                    ||= '/v2/User/delete'
      @uri_user_retrieve                  ||= '/v2/user/retrieve'
      @uri_user_check_existing            ||= '/v2/user/checkexisting'
      @uri_job_branding                   ||= '/branding'
      @uri_resume_own_all                 ||= '/v2/resume/ownall'
      @uri_resume_retrieve                ||= '/v2/resume/retrieve'
      @uri_resume_create                  ||= '/v2/resume/create'
      @uri_resume_update                  ||= '/v2/resume/update'
      @uri_resume_delete                  ||= '/v2/resume/delete'
      @uri_saved_search_retrieve          ||= '/v1/savedsearch/retrieve'
      @uri_saved_search_create            ||= '/v2/savedsearch/create'
      @uri_saved_search_update            ||= '/v2/savedsearch/update'
      @uri_saved_search_delete            ||= '/v1/savedsearch/delete'
      @uri_saved_search_list              ||= '/v1/savedsearch/list'
      @uri_anon_saved_search_create       ||= '/v1/anonymoussavedjobsearch/create'
      @uri_anon_saved_search_delete       ||= '/v1/anonymoussavedjobsearch/delete'
      @uri_tn_join_questions              ||= '/talentnetwork/config/join/questions'
      @uri_tn_job_info                    ||= '/talentnetwork/internal/job'
      @uri_tn_join_form_geo               ||= '/tn/JoinForm/Geo'
      @uri_tn_join_form_branding          ||= '/talentnetwork/config/layout/branding'
      @uri_tn_member_create               ||= '/talentnetwork/member/create'
      @uri_subscription_retrieve          ||= '/v1/user/subscription/retrieve'
      @uri_subscription_modify            ||= '/v1/user/subscription'
      @uri_saved_job_search_create        ||= '/v2/savedsearch/create'
      @uri_spot_retrieve                  ||= '/v2/spot/load'
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
        :uri_application_external         => @uri_application_external,
        :uri_user_change_password         => @uri_user_change_password,
        :uri_user_retrieve                => @uri_user_retrieve,
        :uri_user_check_existing          => @uri_user_check_existing,
        :uri_job_branding                 => @uri_job_branding,
        :uri_resume_own_all               => @uri_resume_own_all,
        :uri_resume_retrieve              => @uri_resume_retrieve,
        :uri_resume_create                => @uri_resume_create,
        :uri_resume_update                => @uri_resume_update,
        :uri_resume_delete                => @uri_resume_delete,
        :uri_saved_search_retrieve        => @uri_saved_search_retrieve,
        :uri_saved_search_create          => @uri_saved_search_create,
        :uri_saved_search_update          => @uri_saved_search_update,
        :uri_saved_search_delete          => @uri_saved_search_delete,
        :uri_saved_search_list            => @uri_saved_search_list,
        :uri_anon_saved_search_create     => @uri_anon_saved_search_create,
        :uri_tn_join_questions            => @uri_tn_join_questions,
        :uri_subscription_retrieve        => @uri_subscription_retrieve,
        :uri_subscription_modify          => @uri_subscription_modify,
        :uri_saved_job_search_create      => @uri_saved_job_search_create,
        :uri_spot_retrieve                => @uri_spot_retrieve
      }
    end

    def set_base_uri (uri)
      @base_uri = uri
    end

    protected
    #################################################################

    def set_defaults

      @dev_key              = 'ruby-cb-api'  # Get a developer key at http://api.careerbuilder.com
      @base_uri             = 'https://api.careerbuilder.com'
      @debug_api            = false
      @time_out             = 5
      @use_json             = true
      @host_site            = Cb.country.US
      @test_mode            = false

      set_default_api_uris
    end
  end
end