require 'json'

module Cb
	class EducationCodeApi
		

		#############################################################
		## Retrieve Education codes by country code
		## 
		## For detailed information around this API please visit:
		## http://api.careerbuilder.com/EducationCodes.aspx
		#############################################################
		def get_education_codes(countrycode)
			
			Cb::Utils::Country.is_valid? countrycode ? countrycode : 'US'

			my_api = Cb::Utils::Api.new()
			cb_response = my_api.cb_get(Cb.configuration.uri_education_code, :query => {:countrycode => countrycode})
			json_hash = JSON.parse(cb_response.response.body)

			code_hash = []

			json_hash['ResponseEducationCodes']['EducationCodes']['Education'].each do |education|
				
				unless education['education_code'].nil?
					code_hash << Cb::CbEducationCode.new(education)
				end
					
			end

			hash_err = my_api.append_api_responses(code_hash, json_hash['ResponseEducationCodes'])
			
			if hash_err.errors.nil?
				return code_hash
			else
				return hash_err
			end	

		end

	end
end
