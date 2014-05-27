
module Cb
  module Requests
    module ApplicationUtils
      private

      def self.resume_info(resume)
        return nil if resume.nil?
        {
          ExternalResumeID: resume[:external_resume_id],
          ResumeFileName: resume[:resume_file_name],
          ResumeData: resume[:resume_data],
          ResumeExtension: resume[:resume_extension],
          ResumeTitle: resume[:resume_title]
        }
      end

      def self.cover_letter_info(cover_letter)
        return nil if cover_letter.nil?
        {
          CoverLetterID: cover_letter[:cover_letter_id],
          CoverLetterText: cover_letter[:cover_letter_text],
          CoverLetterTitle: cover_letter[:cover_letter_title]
        }
      end

      def self.responses_parser(responses)
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
