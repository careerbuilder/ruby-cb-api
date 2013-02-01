module Cb
	class CbJobApi
		#############################################################
		### Run a job search against the given criteria
		#############################################################
		def self.search(*args)
	    	cb_response = Cb.get("/v1/JobSearch", :query => args)
	    	json_hash = JSON.parse(cb_response.response.body)

	    	jobs = []
	    	json_hash.each do |cur_job|
	    		jobs << CbJob.new(cur_job)
	    	end

	    	return jobs
		end

		#############################################################
		### Retrieve a job by did
		#############################################################
		def self.find_by_did(did)
			http_response = self.class.get("/v1/Job", :query => attributes)
			http_response.response.body = http_response.response.body.gsub(/#cdata-section/, 'JobSkin')
			json_hash = JSON.parse(http_response.response.body)

		end
	end
end