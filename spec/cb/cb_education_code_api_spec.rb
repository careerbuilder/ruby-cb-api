require 'spec_helper'

module Cb
  describe Cb::EducationCodeApi do
    context 'get_education_code'

    it 'should get default education code if country is blank ', :vcr => { :cassette_name => 'educationcode/country'} do
      ret_codes_by_country = Cb.education_code.get_education_codes('not real')
    end

    it 'should get the education code for given country ', :vcr => { :cassette_name => 'educationcode/country'} do
      ret_codes_by_country = Cb.education_code.get_education_codes(Cb.country.UK)
    end
  end
end
