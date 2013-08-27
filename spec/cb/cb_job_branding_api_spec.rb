require 'spec_helper'

module Cb
	describe Cb::JobBrandingApi do
		context '.find_by_id' do
			it 'should return valid job branding schema', :vcr => {:cassette_name => 'job/job_branding/find_by_id'} do
				pending 'This is awaiting basic job brandings to exist in production.'
				job = Cb.job.find_by_did 'J3F0RG6NPQGD5K6BNNF'

			    job_branding = job.job_branding

			  	job_branding.should_not == nil
			  	job_branding.errors.empty?.should == true
          job_branding.api_error.should == false
			end

      it 'should not return valid job branding schema', :vcr => {:cassette_name => 'job/job_branding/find_by_id_bad_id'} do
        job_branding = Cb.job_branding.find_by_id 'BAD'

        job_branding.errors.empty?.should == false
        job_branding.errors.values.include?({ 'Message' => 'No branding exists with this Id.' }).should == true
        job_branding.api_error.should == false
      end

      it 'should set api error on bogus request', :vcr => {:cassette_name => 'job/job_branding/bogus_request'} do
        # Returns 404 html which is valid
        #correct_url = Cb.configuration.uri_job_branding

        #Cb.configuration.uri_job_branding  = Cb.configuration.uri_job_branding + 'a'
        #job_branding = Cb.job_branding.find_by_id 'BAD'
        #Cb.configuration.uri_job_branding = correct_url

        #job_branding.api_error.should == true
      end
		end
	end
end
