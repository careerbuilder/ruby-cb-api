require 'spec_helper'

module Cb
  describe Cb::CbJobApi do
    context ".search" do
      it "should perform a blank search" do
        search = Cb::CbJobApi.search()
      end
    end
  end
end