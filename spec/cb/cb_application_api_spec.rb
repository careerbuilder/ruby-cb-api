require 'spec_helper'


module Cb
  describe Cb::ApplicationApi do
    context '.for_job' do
      it 'should return info from application', :vcr => {:cassette_name => 'job/application/for_job'} do
          search = Cb.job_search_criteria.location('Atlanta, GA').radius(10).keywords('customcodes:CBDEV_applyurlno').search()
          job = search[Random.new.rand(0..24)]

          result = Cb.application.for_job job.did
          result.is_a?(Cb::CbApplicationSchema).should == true

          @did = job.did
          job.did.length.should >= 19
      end
    end

    context '.submit_app' do
      it 'should send application info to api', :vcr => {:cassette_name => 'job/application/submit_app'} do

      end

      it 'should get incomplete status message from api' do
        app = Cb::CbApplication.new('bogus-did', 'bogus', 'bogus', 'bogus-resume', 'this-should-be-encoded')
        app.test = true
        app.add_answer('ApplicantName', 'Jesse Retchko, PMP')
        app.add_answer('ApplicantEmail', 'DontSpamMeBro@gmail.com')

        status = Cb.application.submit_app(app)
        status.cb_response.application_status.should == 'Incomplete'
      end
    end
  end
end