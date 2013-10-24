require 'spec_helper'

module Cb
  describe Cb::CbCategory do
    context ".new" do
      it 'should create a new cb category object' do
        args = { 'Name' => { '#text' => String.new, '@language' => String.new } }
        category_obj = Cb::CbCategory.new(args)
        category_obj.is_a?(Cb::CbCategory).should == true
      end
    end
  end
end
