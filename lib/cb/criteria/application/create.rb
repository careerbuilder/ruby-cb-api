module Cb
  module Criteria
    module Application
      class Create
        extend Cb::Utils::FluidAttributes
        fluid_attr_accessor :job_did, :is_submitted, :external_user_id, :vid, :bid, :sid, :site_id, :ipath_id, :tn_did, :resume,
                            :cover_letter, :responses

        def to_json
          {
            JobDID: job_did,
            IsSubmitted: is_submitted,
            ExternalUserID: external_user_id,
            VID: vid,
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
end
