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
  describe Cb::Requests::Application::Create do
    context 'initialize without arguments' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::Application::Create.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_application_create)
          expect(@request.http_method).to eq(:post)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq('DeveloperKey' => Cb.configuration.dev_key,
                                         'HostSite' => Cb.configuration.host_site,
                                         'Content-Type' => 'application/json')
        end

        it 'should have a basic body' do
          expect(@request.body).to eq(
            {
              JobDID: nil,
              IsSubmitted: nil,
              ExternalUserID: nil,
              VID: nil,
              BID: nil,
              SID: nil,
              SiteID: nil,
              IPathID: nil,
              TNDID: nil,
              Resume:  {},
              CoverLetter: {},
              Responses: [],
              Test: 'false'
            }.to_json
          )
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::Application::Create.new(job_did: 'job did',
                                                           is_submitted: 'is submitted',
                                                           external_user_id: 'external user id',
                                                           vid: 'vid',
                                                           bid: 'bid',
                                                           sid: 'sid',
                                                           site_id: 'site id',
                                                           ipath_id: 'ipath id',
                                                           tn_did: 'tn did',
                                                           host_site: 'GR',
                                                           resume: {
                                                             external_resume_id: 'external resume id',
                                                             resume_file_name: 'resume file name',
                                                             resume_data: 'resume data',
                                                             resume_extension: 'resume extension',
                                                             resume_title: 'resume title'
                                                           },
                                                           cover_letter: {
                                                             cover_letter_id: 'cover letter id',
                                                             cover_letter_text: 'cover letter text',
                                                             cover_letter_title: 'cover letter title'
                                                           },
                                                           responses: [
                                                             {
                                                               question_id: 1,
                                                               response_text: 'hello 1' },
                                                             {
                                                               question_id: 2,
                                                               response_text: 'hello 2' },
                                                             {
                                                               question_id: 3,
                                                               response_text: 'hello 3'
                                                             }
                                                           ],
                                                           test: true)
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq(Cb.configuration.uri_application_create)
          expect(@request.http_method).to eq(:post)
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(nil)
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq('DeveloperKey' => Cb.configuration.dev_key,
                                         'HostSite' => 'GR',
                                         'Content-Type' => 'application/json')
        end

        it 'should have a basic body' do
          expect(@request.body).to eq(
            {
              JobDID: 'job did',
              IsSubmitted: 'is submitted',
              ExternalUserID: 'external user id',
              VID: 'vid',
              BID: 'bid',
              SID: 'sid',
              SiteID: 'site id',
              IPathID: 'ipath id',
              TNDID: 'tn did',
              Resume:  {
                ExternalResumeID: 'external resume id',
                ResumeFileName: 'resume file name',
                ResumeData: 'resume data',
                ResumeExtension: 'resume extension',
                ResumeTitle: 'resume title'
              },
              CoverLetter: {
                CoverLetterID: 'cover letter id',
                CoverLetterText: 'cover letter text',
                CoverLetterTitle: 'cover letter title'
              },
              Responses: [
                {
                  QuestionID: 1,
                  ResponseText: 'hello 1'
                },
                {
                  QuestionID: 2,
                  ResponseText: 'hello 2'
                },
                {
                  QuestionID: 3,
                  ResponseText: 'hello 3'
                }
              ],
              Test: 'true'
            }.to_json
          )
        end
      end
    end
  end
end
