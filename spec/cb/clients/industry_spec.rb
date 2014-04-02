require 'spec_helper'

module Cb
  describe Clients::Industry do
    describe '#search' do

      before(:each) do
        content = {:ResponseIndustryCodes => {:Errors=>'null', :CountryCode=>'US', :TimeResponseSent=>'4/1/2014 5:08:10 PM', :IndustryCodes=>{:IndustryCode=>[{:Code=>'IND067', :Name=>{'@language'=>'en','#text'=>'Accounting - Finance'}},{:Code =>'IND001', :Name => {'@language'=>'en','#text'=>'Advertising'}}]}}}

        stub_request(:get, uri_stem(Cb.configuration.uri_job_industry_search)).
            to_return(body: content.to_json)
      end

      context 'search with no params' do
        it 'returns an array of industry codes' do
          response = Cb.industry.search
          response.model[0].is_a?(Cb::Models::Industry).should == true
        end
      end

      context 'search by hostsite' do
        it 'returns an array of WM industry codes' do
          response = Cb.industry.search_by_hostsite('WM')
          response.model.industry[0].is_a?(Cb::Models::Industry).should == true
        end
      end

    end

  end
end
