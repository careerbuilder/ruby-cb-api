require 'json'
#require 'nokogiri'

module Cb
	class ApplicationApi
	  #############################################################
    ## Get an application for a job
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.for_job(did)
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_application, :query => {:JobDID => did})
      json_hash = JSON.parse(cb_response.response.body)
      app_info = CbApp.new(json_hash['ResponseBlankApplication']['BlankApplication']['Questions'])
      my_api.append_api_responses(app_info, json_hash['ResponseBlankApplication'])

      return app_info
    end

    #############################################################
    ## Submit a job application for a registered user
    ## 
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.submit_registered_app(request_xml)
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_post(Cb.configuration.uri_application_registered, :body => request_xml)

      json_hash = JSON.parse(cb_response.response.body)
      begin
        json_hash = JSON.parse(cb_response.response.body)
        if json_hash.empty? == false
          status = json_hash['ResponseApplication']['ApplicationStatus'] == 'Complete (Test)'
        end
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
    def self.submit_app(request_xml)
      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_post(Cb.configuration.uri_application_submit, :body => request_xml)
      json_hash = cb_response.parsed_response
      status = json_hash['ResponseApplication']['ApplicationStatus'] == 'Complete (Test)'
    end
  end
end