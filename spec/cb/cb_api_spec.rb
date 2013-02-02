require 'spec_helper'

module Cb
  describe Cb::CbApi do
    context ".new" do
      it "should create an empty new api object" do
        api = Cb::CbApi.new()
        
        api.is_a?(Cb::CbApi).should == true
      end
    end
  end
end