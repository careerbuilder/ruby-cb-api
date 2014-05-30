require 'spec_helper'

module Cb::Models
  describe Category do
    context ".new" do
      it 'should create a new cb category object' do
        args = { 'Name' => { '#text' => 'name', '@language' => 'lang' },
                 'Code' => 'code' }
        category_obj = Category.new(args)
        category_obj.is_a?(Category).should == true


        category_obj.CategoryCode.should == 'code'
        category_obj.CategoryLanguage.should == 'lang'
        category_obj.CategoryName.should == 'name'

      end
    end
  end
end
