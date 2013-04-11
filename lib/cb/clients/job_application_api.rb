require 'json'

module Cb
  class JobApplicationApi
    #############################################################
    ## Get job application information
    ## 
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    
    def self.get_for(job_did, site_id = '', co_brand = '')
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_job_application, :query => {:JobDID => job_did, :SiteID => site_id, :CoBrand => co_brand})
      json_hash = JSON.parse(cb_response.response.body)

      job_application = CbJobApplication.new(json_hash['ResponseBlankApplication']['BlankApplication'])
      my_api.append_api_responses(job_application, json_hash['ResponseBlankApplication'])

      return job_application 
    end
    
    #############################################################
    ## Submit a job application
    ## 
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    
    # def self.submit(did)

    # end
    
  end # JobApplicationApi
end # Cb