module Cb
  module Models
    class ApplicationExternal

      IPATH_LENGTH = 10
      attr_accessor :job_did, :email, :site_id, :ipath, :apply_url, :is_external_link_apply

      def initialize(args = {})
        @job_did                = args[:job_did] || ''
        @email                  = args[:email] || ''
        @site_id                = args[:site_id] || 'cbnsv'
        @ipath                  = args[:ipath].slice(0,IPATH_LENGTH) || ''
        @is_external_link_apply = args[:is_external_link_apply] || false
        @apply_url              = ''
      end

      def to_xml
        ret = "<Request>"
        ret += "<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
        ret += "<EmailAddress>#{@email}</EmailAddress>"
        ret += "<JobDID>#{@job_did}</JobDID>"
        ret += "<SiteID>#{@site_id}</SiteID>"
        ret += "<IPath>#{@ipath}</IPath>"
        ret += "<IsExternalLinkApply>#{@is_external_link_apply}</IsExternalLinkApply>"
        ret += "<HostSite>#{Cb.configuration.host_site}</HostSite>"
        ret += "</Request>"
        ret
      end
    end
  end
end
