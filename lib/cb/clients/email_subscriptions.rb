# Copyright 2017 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require_relative 'base'
module Cb
  module Clients
    class EmailSubscriptions < Base
      class << self
        def retrieve(args = {})
          cb_client.cb_get(Cb.configuration.uri_subscription_retrieve, query: query(args), headers: headers(args))
        end

        def modify(args = {})
          @unsubscribe_all = args[:unsubscribe_all]
          cb_client.cb_post(Cb.configuration.uri_subscription_modify, body: body(args), headers: post_headers(args))
        end

        private

        def query(args = {})
          {
            ExternalID: args[:external_id],
            HostSite: args[:host_site] || Cb.configuration.host_site
          }
        end

        def post_headers(args = {})
          headers(args).merge('Content-Type' => 'application/xml')
        end

        def body(args = {})
<<eos
<Request>
<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
<ExternalID>#{args[:external_id]}</ExternalID>
<Hostsite>#{args[:host_site] || Cb.configuration.host_site}</Hostsite>
<CareerResources>#{validate args[:career_resources]}</CareerResources>
<ProductSponsorInfo>#{validate args[:product_sponsor_info]}</ProductSponsorInfo>
<ApplicantSurveyInvites>#{validate args[:applicant_survey_invites]}</ApplicantSurveyInvites>
<JobRecs>#{validate args[:job_recs]}</JobRecs>
<DJR>#{validate args[:djr]}</DJR>
<ResumeViewed>#{validate args[:resume_viewed]}</ResumeViewed>
<ApplicationViewed>#{validate args[:application_viewed]}</ApplicationViewed>
<UnsubscribeAll>#{args[:unsubscribe_all]}</UnsubscribeAll>
</Request>
eos
        end

        def validate(value)
          return value unless unsubscribe_all?
          false.to_s
        end

        def unsubscribe_all?
          @unsubscribe_all
        end
      end
    end
  end
end
