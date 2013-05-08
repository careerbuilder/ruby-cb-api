require 'spec_helper'


module Cb
  describe Cb::ApplicationApi do
    context '.for_job' do
      it 'should return info from application', :vcr => {:cassette_name => 'job/application/for_job'} do
          search = Cb.job_search_criteria.location('Atlanta, GA').radius(10).keywords('customcodes:CBDEV_applyurlno').search()
          job = search[Random.new.rand(0..24)]

          result = Cb.application.for_job job.did
          result.is_a?(Cb::CbApp).should == true

          @did = job.did
          job.did.length.should >= 19
      end
    end

    context '.submit_app' do
      it 'should send application info to api', :vcr => {:cassette_name => 'job/application/submit_app'} do
          request_xml  = "<RequestApplication><DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey><Test>true</Test><JobDID>#{Cb.configuration.job_did}</JobDID><HostSite>WR</HostSite><SiteID>cbnsv</SiteID><Responses><Response><QuestionID>ApplicantName</QuestionID><ResponseText>captain morgain</ResponseText></Response><Response><QuestionID>ApplicantEmail</QuestionID><ResponseText>captainmorgan@careerbuilder.com</ResponseText></Response><Response><QuestionID>Resume</QuestionID><ResponseText>Resume goes here.</ResponseText></Response><Response><QuestionID>CoverLetter</QuestionID><ResponseText></ResponseText></Response><Response><QuestionID>6739255</QuestionID><ResponseText></ResponseText></Response><Response><QuestionID>6739256</QuestionID><ResponseText></ResponseText></Response><Response><QuestionID>6739257</QuestionID><ResponseText>222-222-2222</ResponseText></Response></Responses></RequestApplication>"
          status = Cb.application.submit_app(request_xml)
          status.should == true
      end

      it 'should get incomplete status message from api' do
          request_xml  = "<RequestApplication><DeveloperKey>#{Cb.configuration.dev_key}</DeveloperKey><Test>true</Test><JobDID>#{Cb.configuration.job_did}</JobDID></RequestApplication>"
          status = Cb.application.submit_app(request_xml)
          status.should == false
      end
    end
  end
end