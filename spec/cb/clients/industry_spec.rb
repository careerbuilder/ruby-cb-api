require 'spec_helper'

module Cb
  describe Clients::Industry do
    describe '#search' do

      before(:each) do
        content = {:ResponseIndustryCodes => {:Errors=>'null', :CountryCode=>'US', :TimeResponseSent=>'4/1/2014 5:08:10 PM', :IndustryCodes=>{:IndustryCode=>[{:Code=>'IND067', :Name=>{'@language'=>'en','#text'=>'Accounting - Finance'}},{:Code =>'IND001', :Name => {'@language'=>'en','#text'=>'Advertising'}}]}}}

        stub_request(:get, uri_stem(Cb.configuration.uri_job_industry_search)).
            to_return(body: content.to_json)
      end

      context 'search' do
        it 'returns an array of industry codes' do
          response = Cb.industry.search
          expect(response.models.first).to be_an_instance_of(Cb::Models::Industry)
        end
      end

    end

  end
end
