require 'spec_helper'

module Cb::Models
  describe Category do
    context ".new" do
      it 'should create a new cb category object' do
        args = { 'Name' => { '#text' => String.new, '@language' => String.new } }
        category_obj = Category.new(args)
        category_obj.is_a?(Category).should == true
      end
    end
  end
end
