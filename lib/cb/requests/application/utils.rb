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

module Cb
  module Requests
    module ApplicationUtils
      def resume_info(resume)
        return {} if resume.nil?
        {
          ExternalResumeID: resume[:external_resume_id],
          ResumeFileName: resume[:resume_file_name],
          ResumeData: resume[:resume_data],
          ResumeExtension: resume[:resume_extension],
          ResumeTitle: resume[:resume_title]
        }
      end

      def cover_letter_info(cover_letter)
        return {} if cover_letter.nil?
        {
          CoverLetterID: cover_letter[:cover_letter_id],
          CoverLetterText: cover_letter[:cover_letter_text],
          CoverLetterTitle: cover_letter[:cover_letter_title]
        }
      end

      def parsed_responses(responses)
        return [] if responses.nil?
        responses.map do |response|
          {
            QuestionID: response[:question_id],
            ResponseText: response[:response_text]
          }
        end
      end
    end
  end
end
