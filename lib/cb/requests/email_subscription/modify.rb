# Copyright 2016 CareerBuilder, LLC
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
    module EmailSubscription
      class Modify < Base
        def endpoint_uri
          Cb.configuration.uri_subscription_modify
        end

        def http_method
          :post
        end

        def body
          <<eos
<Request>
<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
<ExternalID>#{args[:external_id]}</ExternalID>
<Hostsite>#{args[:host_site]}</Hostsite>
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

        private

        def validate(value)
          return value unless unsubscribe_all?
          false.to_s
        end

        def unsubscribe_all?
          args[:unsubscribe_all] == 'true' || args[:unsubscribe_all] == true
        end
      end
    end
  end
end
