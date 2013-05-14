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
      
        application = Cb::CbApplication.new(job_did, site_id, co_brand, resume_file_name, resume, test)

        application.job_did.should == job_did
        application.site_id.should == site_id
        application.co_brand.should == co_brand
      end
    end
  end
end