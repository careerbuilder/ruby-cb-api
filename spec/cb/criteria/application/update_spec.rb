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

module Cb::Criteria::Application
  describe Update do
    describe '#to_json' do
      context 'when updating real resources' do
        it 'converts the criteria to json' do
          expect(criteria.to_json).to eq(expected_json)
        end
      end

      context 'when test_resources is enabled' do
        before { Cb.configuration.test_resources = true }
        it 'converts the criteria to json' do
          expect(criteria.to_json).to eq(expected_json_with_test)
        end
        after { Cb.configuration.test_resources = false }
      end
    end

    let(:criteria) do
      Update.new
        .application_did('ja_123')
        .job_did('job_123')
        .is_submitted(true)
        .external_user_id('external_user_123')
        .bid('bid_123')
        .vid('hotdog_tsunami')
        .sid('sid_123')
        .site_id('site_123')
        .ipath_id('ipath_123')
        .tn_did('tn_123')
        .resume(resume)
        .cover_letter(cover_letter)
        .responses(responses)
    end
    let(:resume) do
      Resume.new
        .external_resume_id('external_resume_123')
        .resume_file_name('my resume')
        .resume_data(1_010_101_010_101)
        .resume_extension('pdf')
        .resume_title('Nurse')
    end
    let(:cover_letter) do
      CoverLetter.new
        .cover_letter_id('cover_letter_123')
        .cover_letter_text('yeah hi')
        .cover_letter_title('best nurse ever')
    end
    let(:responses) do
      [
        Response.new
          .question_id('question_123')
          .response_text('Yes please')
      ]
    end

    let(:expected_json) do
      {
        ApplicationDID: criteria.application_did,
        JobDID: criteria.job_did,
        IsSubmitted: criteria.is_submitted,
        ExternalUserID: criteria.external_user_id,
        BID: criteria.bid,
        SID: criteria.sid,
        VID: criteria.vid,
        SiteID: criteria.site_id,
        IPathID: criteria.ipath_id,
        TNDID: criteria.tn_did,
        Resume: {
          ExternalResumeID: resume.external_resume_id,
          ResumeFileName: resume.resume_file_name,
          ResumeData: resume.resume_data,
          ResumeExtension: resume.resume_extension,
          ResumeTitle: resume.resume_title
        },
        CoverLetter: {
          CoverLetterID: cover_letter.cover_letter_id,
          CoverLetterText: cover_letter.cover_letter_text,
          CoverLetterTitle: cover_letter.cover_letter_title
        },
        Responses: [{
          QuestionID: responses[0].question_id,
          ResponseText: responses[0].response_text
        }]
      }.to_json
    end
    let(:expected_json_with_test) do
      {
        ApplicationDID: criteria.application_did,
        JobDID: criteria.job_did,
        IsSubmitted: criteria.is_submitted,
        ExternalUserID: criteria.external_user_id,
        BID: criteria.bid,
        SID: criteria.sid,
        VID: criteria.vid,
        SiteID: criteria.site_id,
        IPathID: criteria.ipath_id,
        TNDID: criteria.tn_did,
        Resume: {
          ExternalResumeID: resume.external_resume_id,
          ResumeFileName: resume.resume_file_name,
          ResumeData: resume.resume_data,
          ResumeExtension: resume.resume_extension,
          ResumeTitle: resume.resume_title
        },
        CoverLetter: {
          CoverLetterID: cover_letter.cover_letter_id,
          CoverLetterText: cover_letter.cover_letter_text,
          CoverLetterTitle: cover_letter.cover_letter_title
        },
        Responses: [{
          QuestionID: responses[0].question_id,
          ResponseText: responses[0].response_text
        }],
        Test: true
      }.to_json
    end
  end
end
