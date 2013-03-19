require 'spec_helper'

module Cb
  describe Cb::EducationApi do
    context 'get_education_code'

    it 'should get default education code if country is blank ', :vcr => { :cassette_name => 'educationcode/country'} do
      ret_val = Cb.education_code.get_for('not real')
    end

    it 'should get the education code for given country ', :vcr => { :cassette_name => 'educationcode/uk'} do
      ret_val = Cb.education_code.get_for(Cb.country.UK)
    end
  end
end