require 'spec_helper'

module Cb
		describe Cb::CbEducationCodeApi do 

				context "get_education_code"
						it "should get the education code for given country ", :vcr => { :cassette_name => "educationcode/country"} do
								ec_by_country=[]
								# country_code = Cb::CbEducationCodeApi.get_country()
								country_code = ['UK','US','IN']
								puts 'country_code'
								puts country_code
								i=0
								
								country_code.each do |ctry|	
									j=0
								   puts 'I am in loop'					
									edu_api = Cb::CbEducationCodeApi.new()
					        ret_codes_by_country = edu_api.get_education_code(ctry)
									puts 'ctry'
									puts ctry
									ec_by_country << ctry
									ec_by_country << ret_codes_by_country
									ret_codes_by_country.each do |a|
										puts a.education_code
										puts a.education_name
										if a.blank?
											break
										end
										puts 'counter j=',j
										j += 1
									end
									puts 'counter i= ',i
									i += 1
			        	end
			        	puts 'ec_by_country'
			        	puts ec_by_country
				        
						end
				end
		
end
