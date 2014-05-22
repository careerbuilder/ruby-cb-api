require_relative '../base'

module Cb
  module Requests
    module ApplicationExternal
      class SubmitApplication < Base

        def endpoint_uri
          Cb.configuration.uri_application_external
        end

        def http_method
          :post
        end

        def body
          <<-eos
          <Request>
            <DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
            <EmailAddress>#{args[:email_address]}</EmailAddress>
            <JobDID>#{args[:job_did]}</JobDID>
            <SiteID>#{args[:site_id]}</SiteID>
            <IPath>#{args[:ipath]}</IPath>
            <IsExternalLinkApply>#{args[:is_external_link_apply]}</IsExternalLinkApply>
            <HostSite>#{Cb.configuration.host_site}</HostSite>
          </Request>
          eos
        end

      end
    end
  end
end