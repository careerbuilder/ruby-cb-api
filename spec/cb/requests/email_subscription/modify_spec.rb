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
require 'spec_helper'

module Cb
  describe Cb::Requests::EmailSubscription::Modify do
    describe '#new' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::EmailSubscription::Modify.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_subscription_modify
          expect(@request.http_method).to eq :post
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq nil
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq nil
        end

        it 'should have a basic body' do
          expect(@request.body).to eq <<eos
<Request>
<DeveloperKey>#{ Cb.configuration.dev_key }</DeveloperKey>
<ExternalID></ExternalID>
<Hostsite></Hostsite>
<CareerResources></CareerResources>
<ProductSponsorInfo></ProductSponsorInfo>
<ApplicantSurveyInvites></ApplicantSurveyInvites>
<JobRecs></JobRecs>
<DJR></DJR>
<ResumeViewed></ResumeViewed>
<ApplicationViewed></ApplicationViewed>
<UnsubscribeAll></UnsubscribeAll>
</Request>
eos
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::EmailSubscription::Modify.new(external_id: 'external id',
                                                                 host_site: 'host site',
                                                                 career_resources: 'career resources',
                                                                 product_sponsor_info: 'product sponsor info',
                                                                 applicant_survey_invites: 'applicant survey invites',
                                                                 job_recs: 'job recs',
                                                                 djr: 'djr',
                                                                 resume_viewed: 'resume viewed',
                                                                 application_viewed: 'application viewed',
                                                                 unsubscribe_all: 'unsubscribe all')
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_subscription_modify
          expect(@request.http_method).to eq :post
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq nil
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq nil
        end

        it 'should have a basic body' do
          expect(@request.body).to eq <<eos
<Request>
<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
<ExternalID>external id</ExternalID>
<Hostsite>host site</Hostsite>
<CareerResources>career resources</CareerResources>
<ProductSponsorInfo>product sponsor info</ProductSponsorInfo>
<ApplicantSurveyInvites>applicant survey invites</ApplicantSurveyInvites>
<JobRecs>job recs</JobRecs>
<DJR>djr</DJR>
<ResumeViewed>resume viewed</ResumeViewed>
<ApplicationViewed>application viewed</ApplicationViewed>
<UnsubscribeAll>unsubscribe all</UnsubscribeAll>
</Request>
eos
        end
      end

      context 'ensure unsubscribe all works' do
        before :each do
          @request = Cb::Requests::EmailSubscription::Modify.new(external_id: 'external id',
                                                                 host_site: 'host site',
                                                                 career_resources: 'career resources',
                                                                 product_sponsor_info: 'product sponsor info',
                                                                 applicant_survey_invites: 'applicant survey invites',
                                                                 job_recs: 'job recs',
                                                                 djr: 'djr',
                                                                 resume_viewed: 'resume viewed',
                                                                 application_viewed: 'application viewed',
                                                                 unsubscribe_all: 'true')
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_subscription_modify
          expect(@request.http_method).to eq :post
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq nil
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq nil
        end

        it 'should have a basic body' do
          expect(@request.body).to eq <<eos
<Request>
<DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey>
<ExternalID>external id</ExternalID>
<Hostsite>host site</Hostsite>
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
      end
    end
  end
end
