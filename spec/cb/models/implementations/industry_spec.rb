require 'spec_helper'

module Cb::Models

  describe Industry do

    context 'initialization' do
      it 'should create a new cb industry object' do
        args = { 'Name' => { '#text' => String.new, '@language' => String.new } }
        industry_obj = Industry.new(args)
        industry_obj.is_a?(Industry).should == true
      end
    end
  end
end
