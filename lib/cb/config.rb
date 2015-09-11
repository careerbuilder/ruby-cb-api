# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module Cb
  class Config
    def initialize
      Cb::Utils::Country.inject_convenience_methods
      set_defaults
    end

    def to_hash
      hash = {}

      instance_variables.each do |instance_variable|
        attribute = instance_variable[1..-1].to_sym

        hash[attribute] = send attribute
      end

      hash
    end

    def set_base_uri(uri)
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
      @test_resources       = false
      @observers            = []
      set_default_api_uris
      set_attr_accessors
    end

    private

    #################################################################

    def set_default_api_uris
      @uri_job_category_search ||= '/v1/categories'
      @uri_job_industry_search ||= '/v1/industrycodes'
      @uri_employee_types ||= '/v1/employeetypes'
      @uri_company_find ||= '/Employer/CompanyDetails'
      @uri_job_search ||= '/v1/JobSearch'
      @uri_job_search_v3 ||= '/consumer/jobs/search/'
      @uri_job_find ||= '/v3/Job'
      @uri_education_code ||= '/v1/EducationCodes'
      @uri_recommendation_for_job ||= '/v1/Recommendations/ForJob'
      @uri_recommendation_for_user ||= '/v1/Recommendations/ForUser'
      @uri_recommendation_for_company ||= '/Employer/JobRecommendation'
      @uri_recommendation_for_resume ||= '/jobsearch/recommendations/:resume_hash'
      @uri_application ||= '/cbapi/application/:did'
      @uri_application_create ||= '/cbapi/application/'
      @uri_application_submit ||= '/v1/Application/submit'
      @uri_application_registered ||= '/v3/application/registered'
      @uri_application_external ||= '/v1/application/external'
      @uri_application_form ||= '/cbapi/job/:did/applicationform'
      @uri_user_change_password ||= '/v2/User/ChangePW'
      @uri_user_delete ||= '/v2/User/delete'
      @uri_user_retrieve ||= '/v2/user/retrieve'
      @uri_user_check_existing ||= '/v2/user/checkexisting'
      @uri_user_temp_password ||= '/v1/user/temporarypassword'
      @uri_job_branding ||= '/branding'
      @uri_saved_search_retrieve ||= '/cbapi/savedsearches/:did'
      @uri_saved_search_create ||= '/v2/savedsearch/create'
      @uri_saved_search_update ||= '/cbapi/SavedSearches'
      @uri_saved_search_delete ||= '/cbapi/savedsearches/:did'
      @uri_saved_search_list ||= '/cbapi/savedsearches'
      @uri_anon_saved_search_create ||= '/v1/anonymoussavedjobsearch/create'
      @uri_anon_saved_search_delete ||= '/v1/anonymoussavedjobsearch/delete'
      @uri_tn_join_questions ||= '/talentnetwork/config/join/questions'
      @uri_tn_job_info ||= '/talentnetwork/internal/job'
      @uri_tn_join_form_geo ||= '/tn/JoinForm/Geo'
      @uri_tn_join_form_branding ||= '/talentnetwork/config/layout/branding'
      @uri_tn_member_create ||= '/talentnetwork/member/create'
      @uri_subscription_retrieve ||= '/v2/user/subscription/retrieve'
      @uri_subscription_modify ||= '/v2/user/subscription'
      @uri_saved_job_search_create ||= '/v2/savedsearch/create'
      @uri_work_status_list ||= '/v1/resume/workstatuslist'
      @uri_resume_get ||= '/cbapi/resumes/:resume_hash'
      @uri_resume_put ||= '/cbapi/resumes/:resume_hash'
      @uri_resume_delete ||= '/cbapi/resumes/:resume_hash'
      @uri_resume_post ||= '/consumer/resumedocuments'
      @uri_resume_list ||= '/v3/resume/list'
      @uri_resume_language_codes ||= '/v1/languagecodes'
      @uri_countries ||= '/consumer/datalist/countries'
      @uri_resume_education ||= '/consumer/datalist/ResumeEducation'
      @uri_languages ||= '/consumer/datalist/languages'
      @uri_desired_job_type ||= '/consumer/datalist/desiredjobtype'
      @uri_state_list ||= '/ajax/citysuggest.aspx'
      @uri_report_job ||= '/v1/reportjob'
    end

    def set_attr_accessors
      instance_variables.each { |instance_variable| self.class.send :attr_accessor, instance_variable[1..-1].to_sym }
    end
  end
end
