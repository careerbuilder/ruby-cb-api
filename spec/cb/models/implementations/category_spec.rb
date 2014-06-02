require 'spec_helper'

module Cb::Models
  describe Category do
    context ".new" do
      it 'should create a new cb category object' do
        args = { 'Name' => { '#text' => 'name', '@language' => 'lang' },
                 'Code' => 'code' }
        category_obj = Category.new(args)

        expect(category_obj.is_a?(Category)).to eq(true)


        expect(category_obj.CategoryCode).to eq('code')
        expect(category_obj.CategoryLanguage).to eq('lang')
        expect(category_obj.CategoryName).to eq('name')

      end
    end
  end
end
