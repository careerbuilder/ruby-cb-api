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
		def search(*args)
	    	cb_response = self.api_get(Cb.configuration.uri_job_search, :query => args)
	    	json_hash = JSON.parse(cb_response.response.body)

	    	populate_from json_hash, "ResponseJobSearch"

	    	jobs = []
	    	json_hash["ResponseJobSearch"]["Results"]["JobSearchResult"].each do |cur_job|
	    		jobs << CbJob.new(cur_job)
	    	end

	    	return jobs
		end

		#############################################################
		## Retrieve a job by did
		## 
		## For detailed information around this API please visit:
		## http://api.careerbuilder.com/JobInfo.aspx
		#############################################################
		def find_by_did(did)
			cb_response = self.api_get(Cb.configuration.uri_job_find, :query => {:DID => did})
			json_hash = JSON.parse(cb_response.response.body)

			populate_from json_hash, "ResponseJob"

			CbJob.new(json_hash["ResponseJob"]["Job"])
		end

		private
		#############################################################################

		def populate_from(response, node = "ResponseJobSearch")
			super response, node

      		@total_pages 		= response[node]["TotalPages"].to_i || 0
      		@total_count		= response[node]["TotalCount"].to_i || 0
      		@first_item_index	= response[node]["FirstItemIndex"].to_i || 0
      		@last_item_index 	= response[node]["LastItemIndex"].to_i || 0
		end
	end
end