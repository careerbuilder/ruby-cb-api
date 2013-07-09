require 'json'

module Cb
  class ApplicationExternalApi
    #############################################################
    ## Submit an external application and attach the apply url to the app if successful
    ##
    ## For detailed information around this API please visit:
    ## http://api.careerbuilder.com/ApplicationInfo.aspx
    #############################################################
    def self.submit_app(app)
      raise Cb::IncomingParamIsWrongTypeException unless app.is_a?(Cb::CbApplicationExternal)

      my_api = Cb::Utils::Api.new()
      xml_hash = my_api.cb_post(Cb.configuration.uri_application_external, :body => app.to_xml)
      my_api.append_api_responses(app, xml_hash)

      begin
        app.apply_url = xml_hash["ApplyUrl"] || ''
      end

      return app
    end
  end
end