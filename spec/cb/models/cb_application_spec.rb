require 'spec_helper'

module Cb
  describe Cb::CbApplication do
    context '.new' do
      it 'should create an empty new application' do
        job_did = 'J1234567890'
        site_id = 'xxx'
        co_brand = 'cbmsn'
        resume_file_name = 'JJR4Prez.pdf'
        resume = 'base64stringcomingsoon'
        test = true
      
        application = Cb::CbApplication.new({:job_did => job_did, :site_id => site_id, :co_brand => co_brand, :resume_file_name => resume_file_name, :resume => resume, :test => test})

        application.job_did.should == job_did
        application.site_id.should == site_id
        application.co_brand.should == co_brand
        application.resume_file_name.should == resume_file_name
        application.resume.should == resume
        application.test.should == test
      end
    end

    context '.submit' do
      it 'should submit a new application through unregistered api' do
        job_did = 'J1234567890'
        site_id = 'xxx'
        co_brand = 'cbmsn'
        resume_file_name = 'JJR4Prez.pdf'
        resume = 'base64stringcomingsoon'
        test = true

        application = Cb::CbApplication.new({:job_did => job_did, :site_id => site_id, :co_brand => co_brand, :resume_file_name => resume_file_name, :resume => resume, :test => test})

        application.is_registered?.should == false
        app = application.submit
        app.cb_response.application_status.should == 'Incomplete'
        expect(app.cb_response.errors[0].length).to be >= 1
      end

      it 'should submit a new application through registered api' do
        job_did = 'J1234567890'
        site_id = 'xxx'
        co_brand = 'cbmsn'
        user_external_id = 'XR1234567890USER'
        user_external_resume_id = 'XR1234567890RESU'
        test = true

        application = Cb::CbApplication.new({:job_did => job_did, :site_id => site_id, :co_brand => co_brand, :test => test})
        application.user_external_id = user_external_id
        application.user_external_resume_id = user_external_resume_id

        application.add_answer('ApplicantName', 'Foo Bar')
        application.add_answer('ApplicantEmail', 'DontSpamMeBro@gmail.com')

        application.is_registered?.should == true
        app = application.submit
        app.cb_response.application_status.should == 'Incomplete'
      end
    end
  end
end