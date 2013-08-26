require 'spec_helper'

module Cb
  describe Cb::EducationApi do
    context '.get_for <country>'

    it 'should get default education code if country is blank ', :vcr => { :cassette_name => 'educationcode/country'} do
      ret = Cb.education_code.get_for('not real')

      ret.count.should > 1
      ret.each do | edu |
        edu.is_a?(Cb::CbEducation).should == true

        edu.code.length.should > 1
        edu.language.include?('US').should == true
      end
      ret.api_error.should == false
    end

    it 'should get the education code for given country ', :vcr => { :cassette_name => 'educationcode/uk'} do
      ret = Cb.education_code.get_for(Cb.country.UK)
      ret.count.should > 1
      ret.api_error.should == false
    end
  end
end