require "json"

module Cb
	class CbCompanyApi < CbApi
		#############################################################
		## Retrieve a company by did
		## 
		## For detailed information around this API please visit:
		## http://api.careerbuilder.com/CompanyDetailsInfo.aspx
		#############################################################
		def find_by_did(did)
			cb_response = self.api_get(Cb.configuration.uri_company_find, :query => {:CompanyDID => did})
			json_hash = JSON.parse(cb_response.response.body)

			populate_from json_hash, "Results"

			CbCompany.new(json_hash["Results"]["CompanyProfileDetail"])
		end

		def find_for(obj)
			if obj.is_a?(String)
				did = obj
			elsif obj.is_a?(Cb::CbJob)
				did = obj.company_did
			end

			find_by_did did unless did.empty?
		end

		private
		#############################################################################

		def populate_from(response, node = "Results")
			super response, node
		end
	end
end