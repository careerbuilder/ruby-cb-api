require_relative '../base'
require_relative 'utils'

module Cb
  module Requests
    module Application
      class Update < Base
        include Cb::Requests::ApplicationUtils

        def endpoint_uri
          Cb.configuration.uri_application.sub ':did', @args[:application_did].to_s
        end

        def http_method
          :put
        end

        def headers
          {
            'DeveloperKey' => Cb.configuration.dev_key,
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json'
          }
        end

        def body
          {
            ApplicationDID: @args[:application_did],
            JobDID: @args[:job_did],
            IsSubmitted: @args[:is_submitted],
            ExternalUserID: @args[:external_user_id],
            VID: @args[:vid],
            BID: @args[:bid],
            SID: @args[:sid],
            SiteID: @args[:site_id],
            IPathID: @args[:ipath_id],
            TNDID: @args[:tn_did],
            Resume:  resume_info(@args[:resume]),
            CoverLetter: cover_letter_info(@args[:cover_letter]),
            Responses: responses_parser(@args[:responses]),
            Test: test?
          }.to_json
        end

      end
    end
  end
end
