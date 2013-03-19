require 'spec_helper'

module Cb
		describe Cb::EducationCodeApi do 

				context 'get_education_code'
						it 'should get default education code if country is blank ', :vcr => { :cassette_name => 'educationcode/country'} do				
							country_code = ''									
							ret_codes_by_country = Cb::EducationCodeApi.new().get_education_codes(country_code)

						end

						it 'should get the education code for given country ', :vcr => { :cassette_name => 'educationcode/country'} do						
							country_code = 'WH'
							ret_codes_by_country = Cb::EducationCodeApi.new().get_education_codes(country_code)
	
						end
				end
		
end
