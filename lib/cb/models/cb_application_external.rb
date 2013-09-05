module Cb
  class CbApplicationExternal
    # API Request parameters
    attr_accessor :job_did, :email, :site_id, :ipath

    # Response from External Application API
    # Populated after application submission.
    attr_accessor :apply_url

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
    end # to_xml
  end # CbApplicationExternal
end # Cb