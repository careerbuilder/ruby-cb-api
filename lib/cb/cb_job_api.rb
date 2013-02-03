require "json"

module Cb
	class CbJobApi < CbApi
		attr_accessor :total_pages, :total_count, :first_item_index, :last_item_index

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