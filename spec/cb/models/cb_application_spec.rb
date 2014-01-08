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
      let(:application) { Cb::CbApplication.new }

      context 'when the application is for an unregistered user' do
        before(:each) do
          application.user_external_id = String.new
          application.resume = String.new

          stub_request(:post, uri_stem(Cb.configuration.uri_application_submit)).
            with(:body => anything).
            to_return(:body => { ResponseApplication: { ApplicationStatus: 'Incomplete', Errors: nil, RedirectURL: 'http://bananaz.com' } }.to_json)
        end

        it 'submits a new application through unregistered api' do
          application.is_registered?.should == false
          app = application.submit
          app.cb_response.application_status.should == 'Incomplete'
          expect(app.cb_response.errors).to eq nil
        end
      end

      context 'when the application is for a registered user' do
        before(:each) do
          # these are the things that mean an application is for a registered user
          application.user_external_id = 'xid'
          application.resume = String.new

          stub_request(:post, uri_stem(Cb.configuration.uri_application_registered)).
            with(:body => anything).
            to_return(:body => { ResponseApplication: { ApplicationStatus: 'Incomplete', Errors: nil, RedirectURL: 'http://bananaz.com' } }.to_json)
        end

        it 'submits a new application through registered api' do
          application.is_registered?.should == true
          app = application.submit
          app.cb_response.application_status.should == 'Incomplete'
          expect(app.cb_response.errors).to eq nil
        end
      end
    end
  end
end
