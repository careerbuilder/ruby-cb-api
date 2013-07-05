require 'spec_helper'

module Cb
	describe Cb::JobBrandingApi do
		context '.find_by_id' do
			# Need a job branding to exist in production.
			# it 'should return valid job branding schema', :vcr => {:cassette_name => 'job/job_branding/find_by_id'} do
			#    	job_branding = Cb.job_branding.find_by_id 'JB965X3651N9KZ8CLWH4'
			# end

		  	it 'should not return valid job branding schema', :vcr => {:cassette_name => 'job/job_branding/find_by_id_bad_id'} do
		    	job_branding = Cb.job_branding.find_by_id 'BAD'

		    	job_branding.cb_response.errors.empty?.should == false
		    	job_branding.cb_response.errors.include?({ 'Message' => 'No branding exists with this Id.' }).should == true
		  	end
		end
	end
end
