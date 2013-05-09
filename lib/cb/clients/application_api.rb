require 'json'

module Cb
	class ApplicationApi
	  #############################################################
    ## Get an application for a job
    ## Takes in either a Cb::CbJob, or a string (which should contain a did)
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.for_job(job)
      did = job.did if job.is_a?(Cb::CbJob) else did = job
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_application, :query => {:JobDID => did})
      json_hash = JSON.parse(cb_response.response.body)
      app_info = CbApp.new(json_hash['ResponseBlankApplication']['BlankApplication'])
      my_api.append_api_responses(app_info, json_hash['ResponseBlankApplication'])

      return app_info
    end

    #############################################################
    ## Submit a job application for a registered user
    ## 
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.submit_registered_app(app)
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_post(Cb.configuration.uri_application_registered, :body => application_xml)

      json_hash = JSON.parse(cb_response.response.body)
      begin
        json_hash = JSON.parse(cb_response.response.body)
        status = json_hash['ResponseApplication']['ApplicationStatus'] == 'Complete (Test)' unless json_hash.empty?
      rescue
          status = false
      end

      return status
    end

    #############################################################
    ## Submit a job application
    ## 
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.submit_app(app)
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_post(Cb.configuration.uri_application_submit, :body => application_xml)
      json_hash = cb_response.parsed_response
      status = json_hash['ResponseApplication']['ApplicationStatus'] == 'Complete (Test)'
    end
  end
end