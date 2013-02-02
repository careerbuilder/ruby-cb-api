require "json"

module Cb
	class CbJobApi < CbApi
		#############################################################
		## Run a job search against the given criteria
		##
		## For detailed information around this API please visit:
		## http://api.careerbuilder.com/JobSearchInfo.aspx
		#############################################################
		def self.search(*args)
	    	cb_response = self.get(Cb.configuration.uri_job_search, :query => args)
	    	json_hash = JSON.parse(cb_response.response.body)

	    	jobs = []
	    	json_hash["ResponseJobSearch"]["Results"]["JobSearchResult"].each do |cur_job|
	    		jobs << CbJob.new(cur_job)
	    	end

	    	return jobs
		end

		#############################################################
		### Retrieve a job by did
		#############################################################
		def self.find_by_did(did)
			http_response = self.class.get(Cb.configuration.uri_job_find, :query => attributes)
			http_response.response.body = http_response.response.body.gsub(/#cdata-section/, 'JobSkin')
			json_hash = JSON.parse(http_response.response.body)

		end
	end
end


#{, "Results"=>{"JobSearchResult"=>[{"Company"=>"Graham Packaging Company", "CompanyDID"=>nil, "CompanyDetailsURL"=>nil, "DID"=>"JHP6X874VQPT2DHD7D2", "OnetCode"=>"51-1011.00", "ONetFriendlyTitle"=>"Supervisors of Production and Operating Staff", "DescriptionTeaser"=>"Graham Packaging is a global leader in the design, sale, and manufacture of value-added, custom blow-molded plastic containers for branded foods and...", "Distance"=>nil, "EmploymentType"=>"Full-Time", "JobDetailsURL"=>"http://api.careerbuilder.com/v1/joblink?TrackingID=DQSMDRS0&DID=JHP6X874VQPT2DHD7D2", "JobServiceURL"=>"https://api.careerbuilder.com/v1/job?DID=JHP6X874VQPT2DHD7D2&DeveloperKey=WDhd88S735S3V2NWZKPD", "Location"=>"NH - Bedford", "LocationLatitude"=>"42.9407", "LocationLongitude"=>"-71.5309", "PostedDate"=>"2/2/2013", "Pay"=>"N/A", "SimilarJobsURL"=>"http://www.careerbuilder.com/Jobs/SimilarJobs.aspx?ipath=JELO&job_did=JHP6X874VQPT2DHD7D2", "JobTitle"=>"Night Shift Lead (Hourly Supervisor)", "CompanyImageURL"=>nil}