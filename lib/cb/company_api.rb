require 'json'

module Cb
	class CompanyApi
		#############################################################
		## Retrieve a company by did
		## 
		## For detailed information around this API please visit:
		## http://api.careerbuilder.com/CompanyDetailsInfo.aspx
		#############################################################
		def self.find_by_did(did)
      my_api = Cb::Utils::Api.new()
			cb_response = my_api.cb_get(Cb.configuration.uri_company_find, :query => {:CompanyDID => did})
			json_hash = JSON.parse(cb_response.response.body)

			CbCompany.new(json_hash['Results']['CompanyProfileDetail'])
		end

		def self.find_for(obj)
			if obj.is_a?(String)
				did = obj
			elsif obj.is_a?(Cb::CbJob)
				did = obj.company_did
			end

			find_by_did did unless did.empty?
		end
	end
end