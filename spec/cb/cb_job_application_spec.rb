require 'spec_helper'

module Cb
  describe Cb::CbJobApplication do
    context '.new' do
      it 'should create an empty new application' do
        job_did = 'J1234567890'
        title = "Brogrammers 4 Life"
        site_id = "xxx"
        co_brand = "cbmsn"
        apply_url = "careerbuilder.com"
        total_questions = 4
        total_required_questions = 4
        # questions =
        submit_service_url = "careerbuilder.com"
      
        application = Cb::CbJobApplication.new('JobDID' => job_did, 'SiteID' => site_id, 'CoBrand' => co_brand, 'ApplyURL' => apply_url,
         'JobTitle' => title, 'TotalQuestions' => total_questions, 'TotalRequiredQuestions' => total_required_questions, 'ApplicationSubmitServiceURL' => submit_service_url)

        application.job_did.should == job_did
        application.title.should == title
        application.site_id.should == site_id
        application.co_brand.should == co_brand
        application.apply_url.should == apply_url
        application.total_questions.should == total_questions
        application.total_required_questions.should == total_required_questions
        application.submit_service_url.should == submit_service_url
      end
    end
  end
end