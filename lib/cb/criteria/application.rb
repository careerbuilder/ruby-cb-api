module Cb
  module Criteria
    class Application
      extend Cb::Utils::FluidAttributes
      fluid_attr_accessor :did, :job_did, :resume, :is_submitted, :bid, :sid, :site_id, :ipath_id, :application_did,
                          :cover_letter, :responses, :tn_did, :external_user_id, :redirect_url

      def to_json
        {
          JobDID: job_did,
          ExternalUserID: external_user_id,
          BID: bid,
          SID: sid,
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
        }.to_json
      end

    end
  end
end
