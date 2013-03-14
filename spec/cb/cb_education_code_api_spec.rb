require 'spec_helper'

module Cb
		describe Cb::EducationCodeApi do 

				context "get_education_code"
						it "should get default education code if country is blank ", :vcr => { :cassette_name => "educationcode/country"} do				
							country_code = ''									
							ret_codes_by_country = Cb::EducationCodeApi.new().get_education_code(country_code)
							begin
								ret_codes_by_country.each do |a|

									puts a.education_code
									puts a.education_name
									puts("\n")
			         	end
							rescue
								puts 'Errors found'
								puts ret_codes_by_country.errors
							end
						end

						it "should get the education code for given country ", :vcr => { :cassette_name => "educationcode/country"} do						
							country_code = 'UK01'
							ret_codes_by_country = Cb::EducationCodeApi.new().get_education_code(country_code)
							begin
								ret_codes_by_country.each do |a|
									puts a.education_code
									puts a.education_name
									puts("\n")
			         	end
							rescue
								puts 'Errors found'
								puts ret_codes_by_country.errors
							end

						end
				end
		
end
