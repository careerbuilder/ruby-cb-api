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

module Cb
  describe Responses::EmailSubscription::Response do
    let(:json_hash) do
      {
        'Errors' => [],
        'Status' => 'Success',
        'SubscriptionValues' => {
          'CareerResources' => true,
          'ProductSponsorInfo' => false,
          'ApplicantSurveyInvites' => true,
          'JobRecs' => true,
          'DJR' => false,
          'ResumeViewed' => true,
          'ApplicationViewed' => false
        }
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        expect(Responses::EmailSubscription::Response.new(json_hash).class).to eq Responses::EmailSubscription::Response
      end

      it 'instantiates new model objects' do
        model = Responses::EmailSubscription::Response.new(json_hash).model

        expect(model.class).to eq Cb::Models::EmailSubscription

        expect(model.career_resources).to eq 'true'
        expect(model.product_sponsor_info).to eq 'false'
        expect(model.applicant_survey_invites).to eq 'true'
        expect(model.job_recs).to eq 'true'
        expect(model.djr).to eq 'false'
        expect(model.resume_viewed).to eq 'true'
        expect(model.application_viewed).to eq 'false'
      end
    end
  end
end
