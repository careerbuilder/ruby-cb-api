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
require 'spec_helper'

module Cb::Models
  describe EmailSubscription do
    context '.new' do
      it 'should create an empty new email subscription' do
        career_resources = 'true'
        product_sponsor_info = 'true'
        applicant_survey_invites = 'false'
        job_recs = 'true'

        subscription = EmailSubscription.new('CareerResources' => career_resources,
                                             'ProductSponsorInfo' => product_sponsor_info,
                                             'ApplicantSurveyInvites' => applicant_survey_invites,
                                             'JobRecs' => job_recs)

        expect(subscription.career_resources).to eq(career_resources)
        expect(subscription.product_sponsor_info).to eq(product_sponsor_info)
        expect(subscription.applicant_survey_invites).to eq(applicant_survey_invites)
        expect(subscription.job_recs).to eq(job_recs)
      end
    end
  end
end
