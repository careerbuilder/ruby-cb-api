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
  module Criteria
    module Application
      class Update
        extend Cb::Utils::FluidAttributes
        fluid_attr_accessor :application_did, :job_did, :is_submitted, :external_user_id, :vid, :bid, :sid, :site_id,
                            :ipath_id, :tn_did, :resume, :cover_letter, :responses

        def to_json
          crit = {
            ApplicationDID: application_did,
            JobDID: job_did,
            IsSubmitted: is_submitted,
            ExternalUserID: external_user_id,
            BID: bid,
            SID: sid,
            VID: vid,
            SiteID: site_id,
            IPathID: ipath_id,
            TNDID: tn_did,
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
            Responses: responses.map do |response|
              {
                QuestionID: response.question_id,
                ResponseText: response.response_text
              }
            end
          }
          crit[:Test] = true if Cb.configuration.test_resources
          crit.to_json
        end
      end
    end
  end
end
