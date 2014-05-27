
module Cb
  module Requests
    module ApplicationUtils

      def resume_info(resume)
        return nil if resume.nil?
        {
          ExternalResumeID: resume[:external_resume_id],
          ResumeFileName: resume[:resume_file_name],
          ResumeData: resume[:resume_data],
          ResumeExtension: resume[:resume_extension],
          ResumeTitle: resume[:resume_title]
        }
      end

      def cover_letter_info(cover_letter)
        return nil if cover_letter.nil?
        {
          CoverLetterID: cover_letter[:cover_letter_id],
          CoverLetterText: cover_letter[:cover_letter_text],
          CoverLetterTitle: cover_letter[:cover_letter_title]
        }
      end

      def responses_parser(responses)
        return if responses.nil?
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
