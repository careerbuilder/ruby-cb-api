require 'spec_helper'

module Cb
  describe Criteria::Application do
    describe '#to_xml' do
      let(:criteria) {
        Criteria::Application.new
        .job_did('job_123')
        .external_user_id('external_user_123')
        .bid('bid_123')
        .sid('sid_123')
        .site_id('site_123')
        .ipath_id('ipath_123')
        .tn_did('tn_123')
        .resume(resume)
        .cover_letter(cover_letter)
        .responses(responses)
      }
      let(:resume) {
        Criteria::Application::Resume.new
        .external_resume_id('external_resume_123')
        .resume_file_name('my resume')
        .resume_data(1010101010101)
        .resume_extension('pdf')
        .resume_title('Nurse')
      }
      let(:cover_letter) {
        Criteria::Application::CoverLetter.new
        .cover_letter_id('cover_letter_123')
        .cover_letter_text('yeah hi')
        .cover_letter_title('best nurse ever')
      }
      let(:responses) {
        [
          Criteria::Application::Response.new
          .question_id('question_123')
          .response_text('Yes please')
        ]
      }

      it 'converts the criteria to xml' do
        expect(criteria.to_xml).to eq(<<eos)
<?xml version=\"1.0\"?>
<Application>
  <JobDID>job_123</JobDID>
  <ExternalUserID>external_user_123</ExternalUserID>
  <BID>bid_123</BID>
  <SID>sid_123</SID>
  <SiteID>site_123</SiteID>
  <IPathID>ipath_123</IPathID>
  <TNDID>tn_123</TNDID>
  <Resume>
    <ExternalResumeID>external_resume_123</ExternalResumeID>
    <ResumeFileName>my resume</ResumeFileName>
    <ResumeData>1010101010101</ResumeData>
    <ResumeExtension>pdf</ResumeExtension>
    <ResumeTitle>Nurse</ResumeTitle>
  </Resume>
  <CoverLetter>
    <CoverLetterID>cover_letter_123</CoverLetterID>
    <CoverLetterText>yeah hi</CoverLetterText>
    <CoverLetterTitle>best nurse ever</CoverLetterTitle>
  </CoverLetter>
  <Responses>
    <Response>
      <QuestionID>question_123</QuestionID>
      <ResponseText>Yes please</ResponseText>
    </Response>
  </Responses>
</Application>
eos
      end

    end
  end
end
