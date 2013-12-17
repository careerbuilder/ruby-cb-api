require 'json'

module Cb
  module Clients
    class Application

      def self.for_job(job)
        job.is_a?(Cb::Models::Job) ? did = job.did : did = job
        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_get(Cb.configuration.uri_application, :query => {:JobDID => did})

        if json_hash.has_key?('ResponseBlankApplication')
          if json_hash['ResponseBlankApplication'].has_key?('BlankApplication')
            app = Cb::Models::ApplicationSchema.new(json_hash['ResponseBlankApplication']['BlankApplication'])
          end

          my_api.append_api_responses(app, json_hash['ResponseBlankApplication'])
        end

        my_api.append_api_responses(app, json_hash)
      end

      def self.submit_registered_app(app)
        return send_to_api(Cb.configuration.uri_application_registered, app)
      end

      def self.submit_app(app)
        return send_to_api(Cb.configuration.uri_application_submit, app)
      end

      def self.send_to_api(uri, app)
        raise Cb::IncomingParamIsWrongTypeException unless app.is_a?(Cb::Models::Application)

        my_api = Cb::Utils::Api.new
        json_hash = my_api.cb_post("#{uri}?ipath=#{app.ipath}", :body => app.to_xml)

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

        my_api.append_api_responses(app, json_hash)
      end
    end
  end
end
