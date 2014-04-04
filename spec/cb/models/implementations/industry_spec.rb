require 'spec_helper'

module Cb::Models

  describe Industry do

    context 'initialization' do
      it 'should create a new cb industry object' do
        args = {'Code'=>'IND067', 'Name'=>{'@language'=>'en', '#text'=>'Accounting - Finance'}}

        industry_obj = Industry.new(args)
        expect(industry_obj).to be_kind_of(Industry)
      end
    end
  end
end
