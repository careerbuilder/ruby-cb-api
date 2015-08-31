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
            <IPath>#{ipath}</IPath>
            <IsExternalLinkApply>#{args[:is_external_link_apply]}</IsExternalLinkApply>
            <HostSite>#{args[:host_site] || Cb.configuration.host_site}</HostSite>
            <SessionIdentifier>#{args[:sid]}</SessionIdentifier>
          </Request>
          eos
        end

        private

        def ipath
          return '' unless args[:ipath].is_a?(String)
          ipath_length = 10

          args[:ipath].slice(0, ipath_length)
        end
      end
    end
  end
end
