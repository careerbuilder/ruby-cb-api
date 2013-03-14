require "json"

module Cb
	class EducationCodeApi
		

		#############################################################
		## Retrieve Education codes by country code
		## 
		## For detailed information around this API please visit:
		## http://api.careerbuilder.com/EducationCodes.aspx
		#############################################################
		def get_education_code(countrycode)
			
			a = CbCountryCode.instance
			std_country_code = a.load_country(countrycode)
		  
			my_api = Cb::Utils::Api.new()
			cb_response = my_api.cb_get(Cb.configuration.uri_education_code, :query => {:countrycode => std_country_code})
			json_hash = JSON.parse(cb_response.response.body)

			code_hash = []

			json_hash['ResponseEducationCodes']['EducationCodes']['Education'].each do |education|
				begin
					if !education.nil?
						code_hash << Cb::CbEducationCode.new(education)
					end
				rescue
					 puts 'education failing'
					 puts education
				end
			
			end

			a = my_api.append_api_responses(code_hash, json_hash['ResponseEducationCodes'])

			
			# access the content within the returned object
			# puts a.errors
			# puts a.time_sent
			
			if a.errors.nil?
				return code_hash
			else
				# @err_ret = 'Error occurred - please verify your country code.'
				# puts err_ret
				return a
			end	


		end

	end
end
