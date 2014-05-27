require_relative '../base'
require_relative 'utils'

module Cb
  module Requests
    module Application
      class Update < Base
        include Cb::Requests::ApplicationUtils

        def endpoint_uri
          Cb.configuration.uri_application.sub ':did', @args[:did]
        end

        def http_method
          :put
        end

        def body
          {
            ApplicationDID: application_did,
            JobDID: job_did,
            IsSubmitted: is_submitted,
            ExternalUserID: external_user_id,
            BID: bid,
            SID: sid,
            VID: vid,
            SiteID: site_id,
            IPathID: ipath_id,
            TNDID: tn_did,
            Resume:  resume_info(@args[:resume]),
            CoverLetter: cover_letter_info(@args[:cover_letter]),
            Responses: responses_parser(@args[:responses]),
            Test: test?
        }
        end

      end
    end
  end
end
