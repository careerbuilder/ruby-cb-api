require "json"

module Cb
	class CbEducationCodeApi < CbApi
		

		#############################################################
		## Retrieve Education codes by country code
		## 
		## For detailed information around this API please visit:
		## http://api.careerbuilder.com/EducationCodes.aspx
		#############################################################
		def get_education_code(countrycode)
		
			cb_response = self.api_get(Cb.configuration.uri_education_code, :query => {:countrycode => countrycode})
			json_hash = JSON.parse(cb_response.response.body)

			# puts '##cb_response##'
			# puts cb_response
			populate_from json_hash, "ResponseEducationCodes"

			
			code_hash = []
			json_hash["ResponseEducationCodes"]["EducationCodes"]["Education"].each do |education|
				code_hash << CbEducationCode.new(education)
				# puts 'education'
				# puts education
			end
			puts '##code_hash##'
			puts code_hash
			# code_hash.each do |a|
			# 	puts a.education_code
			# 	puts a.education_name

			# end


			return code_hash

		end


		def get_country()
			    country_code << ["UK","US","IN"]

			return country_code
		end
	end
end
