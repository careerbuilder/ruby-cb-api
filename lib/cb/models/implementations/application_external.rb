# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module Cb
  module Models
    class ApplicationExternal
      IPATH_LENGTH = 10
      attr_accessor :job_did, :email, :site_id, :ipath, :apply_url, :is_external_link_apply

      def initialize(args = {})
        @job_did                = args[:job_did] || ''
        @email                  = args[:email] || ''
        @site_id                = args[:site_id] || 'cbnsv'
        @ipath                  = args[:ipath].slice(0, IPATH_LENGTH) rescue ''
        @is_external_link_apply = args[:is_external_link_apply] || false
        @apply_url              = ''
      end

      def to_xml
        ret = '<Request>'
        ret += "<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>"
        ret += "<EmailAddress>#{@email}</EmailAddress>"
        ret += "<JobDID>#{@job_did}</JobDID>"
        ret += "<SiteID>#{@site_id}</SiteID>"
        ret += "<IPath>#{@ipath}</IPath>"
        ret += "<IsExternalLinkApply>#{@is_external_link_apply}</IsExternalLinkApply>"
        ret += "<HostSite>#{Cb.configuration.host_site}</HostSite>"
        ret += '</Request>'
        ret
      end
    end
  end
end
