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
			end

		  	it 'should not return valid job branding schema', :vcr => {:cassette_name => 'job/job_branding/find_by_id_bad_id'} do
		    	job_branding = Cb.job_branding.find_by_id 'BAD'

		    	job_branding.errors.empty?.should == false
		    	job_branding.errors.values.include?({ 'Message' => 'No branding exists with this Id.' }).should == true
		  	end
		end
	end
end
