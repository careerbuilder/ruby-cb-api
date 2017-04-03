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
require 'spec_helper'

module Cb
  describe Cb::Clients::EmailSubscriptions do
    describe '#get' do
      subject { Cb::Clients::EmailSubscriptions.get(oauth_token: 'token', external_id: 'Uzer') }

      let(:headers) do
        {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'deflate, gzip',
          'Authorization' => 'Bearer token',
          'Content-Type' => 'application/json',
          'Developerkey' => Cb.configuration.dev_key
        }
      end

      let(:uri) { "https://api.careerbuilder.com/v2/user/subscription/retrieve?ExternalID=Uzer&HostSite=US&developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
      let(:stub) do
        stub_request(:get, uri).
          with(headers: headers).
          to_return(status: 200, body: {}.to_json)
      end


      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }
    end

    describe '#post' do
      subject { Cb::Clients::EmailSubscriptions.post(params) }

      let(:headers) do
        {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'deflate, gzip',
          'Authorization' => 'Bearer token',
          'Content-Type' => 'application/xml',
          'Developerkey' => Cb.configuration.dev_key
        }
      end

      let(:params) { { oauth_token: 'token', external_id: 'Uzer', career_resources: false, product_sponsor_info: true, applicant_survey_invites: false, job_recs: true, djr: true, resume_viewed: false, application_viewed: false, unsubscribe_all: false } }
      let(:uri) { "https://api.careerbuilder.com/v2/user/subscription?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
      let(:stub) do
        stub_request(:post, uri).
          with(headers: headers, body: expected_body).
          to_return(status: 200, body: {}.to_json)
      end
      let(:expected_body) do
<<eos
<Request>
<DeveloperKey>ruby-cb-api</DeveloperKey>
<ExternalID>Uzer</ExternalID>
<Hostsite>US</Hostsite>
<CareerResources>false</CareerResources>
<ProductSponsorInfo>true</ProductSponsorInfo>
<ApplicantSurveyInvites>false</ApplicantSurveyInvites>
<JobRecs>true</JobRecs>
<DJR>true</DJR>
<ResumeViewed>false</ResumeViewed>
<ApplicationViewed>false</ApplicationViewed>
<UnsubscribeAll>false</UnsubscribeAll>
</Request>
eos
      end

      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }

      context 'with unsubscribe_all true' do
        let(:params) { { oauth_token: 'token', external_id: 'Uzer', career_resources: true, unsubscribe_all: true } }
        let(:expected_body) do
<<eos
<Request>
<DeveloperKey>ruby-cb-api</DeveloperKey>
<ExternalID>Uzer</ExternalID>
<Hostsite>US</Hostsite>
<CareerResources>false</CareerResources>
<ProductSponsorInfo>false</ProductSponsorInfo>
<ApplicantSurveyInvites>false</ApplicantSurveyInvites>
<JobRecs>false</JobRecs>
<DJR>false</DJR>
<ResumeViewed>false</ResumeViewed>
<ApplicationViewed>false</ApplicationViewed>
<UnsubscribeAll>true</UnsubscribeAll>
</Request>
eos
      end

        it { expect(stub).to have_been_requested }
      end
    end
  end
end
