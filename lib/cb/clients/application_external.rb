require 'json'

module Cb
  module Clients
    class ApplicationExternal

      def self.submit_app(app)
        raise Cb::IncomingParamIsWrongTypeException unless app.is_a?(Cb::CbApplicationExternal)

        my_api = Cb::Utils::Api.new
        xml_hash = my_api.cb_post(Cb.configuration.uri_application_external, :body => app.to_xml)

        if xml_hash.has_key? 'ApplyUrl'
          app.apply_url = xml_hash['ApplyUrl']
        else
          app.apply_url = ''
        end

        my_api.append_api_responses(app, xml_hash)
      end

    end
  end
end
