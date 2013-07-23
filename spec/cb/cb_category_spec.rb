require 'spec_helper'

module Cb
  describe Cb::CbCategory do
    context ".new" do
      it "should create a new cb category object" do
        VCR.use_cassette('Cb Category Object') do
          #category_obj = Cb::CbCategory.new()
          #category_obj.is_a?(Cb::CbCategory).should == true
        end
      end
    end
  end
end