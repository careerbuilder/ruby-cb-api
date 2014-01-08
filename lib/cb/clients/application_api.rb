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
      json_hash = my_api.cb_get(Cb.configuration.uri_application, :query => {:JobDID => did})

      if json_hash.has_key?('ResponseBlankApplication')
        if json_hash['ResponseBlankApplication'].has_key?('BlankApplication')
          app = Cb::CbApplicationSchema.new(json_hash['ResponseBlankApplication']['BlankApplication'])
        end

        my_api.append_api_responses(app, json_hash['ResponseBlankApplication'])
      end

      my_api.append_api_responses(app, json_hash)

      return app
    end

    #############################################################
    ## Submit a job application for a registered user
    ## 
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.submit_registered_app(app)
      return send_to_api(Cb.configuration.uri_application_registered, app)
    end

    #############################################################
    ## Submit a job application
    ## 
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.submit_app(app)
      return send_to_api(Cb.configuration.uri_application_submit, app)
    end

    def self.send_to_api(uri, app)
      raise Cb::IncomingParamIsWrongTypeException unless app.is_a?(Cb::CbApplication)

      my_api = Cb::Utils::Api.new()
      json_hash = my_api.cb_post("#{uri}?ipath=#{app.ipath}", :body => app.to_xml)

      begin
        if json_hash.has_key? 'ResponseApplication'
          if json_hash['ResponseApplication'].has_key? 'RedirectURL'
            app.redirect_url = json_hash['ResponseApplication']['RedirectURL']
          else
            app.redirect_url = ''
          end

          my_api.append_api_responses(app, json_hash['ResponseApplication'])
        else
          app.redirect_url = ''
        end

      end

      my_api.append_api_responses(app, json_hash)

      return app
    end
  end
end