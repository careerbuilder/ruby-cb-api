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
      job.is_a?(Cb::CbJob) ? did = job.did : did = job

      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_get(Cb.configuration.uri_application, :query => {:JobDID => did})
      json_hash = JSON.parse(cb_response.response.body)
      app = Cb::CbApplicationSchema.new(json_hash['ResponseBlankApplication']['BlankApplication'])
      my_api.append_api_responses(app, json_hash['ResponseBlankApplication'])

      return app
    end

    #############################################################
    ## Submit a job application for a registered user
    ## 
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.submit_registered_app(app)
      raise Cb::IncomingParamIsWrongTypeException unless app.is_a?(Cb::CbApplication)

      my_api = Cb::Utils::Api.new()
      cb_response = my_api.cb_post(Cb.configuration.uri_application_registered, :body => app.to_xml)

      json_hash = JSON.parse(cb_response.response.body)
      begin
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
      raise Cb::IncomingParamIsWrongTypeException unless app.is_a?(Cb::CbApplication)

      my_api = Cb::Utils::Api.new()
      xml_hash = my_api.cb_post(Cb.configuration.uri_application_submit, :body => app.to_xml)
      my_api.append_api_responses(app, xml_hash['ResponseApplication'])

      return app
    end
  end
end