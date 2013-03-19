require 'json'

module Cb
	class EducationApi
		#############################################################
		## Retrieve Education codes by country code
		## 
		## For detailed information around this API please visit:
		## http://api.careerbuilder.com/EducationCodes.aspx
		#############################################################
		def get_for(country)
			Cb::Utils::Country.is_valid? country ? country : 'US'

			my_api = Cb::Utils::Api.new()
			cb_response = my_api.cb_get(Cb.configuration.uri_education_code, :query => {:countrycode => country})
			json_hash = JSON.parse(cb_response.response.body)

			codes = []
			json_hash['ResponseEducationCodes']['EducationCodes']['Education'].each do | education |
        codes << Cb::CbEducation.new(education)
      end
      my_api.append_api_responses(codes, json_hash['ResponseEducationCodes'])

      return codes
		end
	end
end