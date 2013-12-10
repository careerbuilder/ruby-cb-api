module Cb
  module Models
    class ApplicationExternal
      attr_accessor :job_did, :email, :site_id, :ipath, :apply_url

      def initialize(args = {})
        @job_did          = args[:job_did] || ''
        @email            = args[:email] || ''
        @site_id          = args[:site_id] || 'cbnsv'
        @ipath            = args[:ipath] || ''
        @apply_url        = ''
      end

      def to_xml
        ret = "<Request>"
        ret += "<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
        ret += "<EmailAddress>#{@email}</EmailAddress>"
        ret += "<JobDID>#{@job_did}</JobDID>"
        ret += "<SiteID>#{@site_id}</SiteID>"
        ret += "<IPath>#{@ipath}</IPath>"
        ret += "<IsExternalLinkApply>false</IsExternalLinkApply>"
        ret += "<HostSite>#{Cb.configuration.host_site}</HostSite>"
        ret += "</Request>"
        ret
      end
    end
  end
end
