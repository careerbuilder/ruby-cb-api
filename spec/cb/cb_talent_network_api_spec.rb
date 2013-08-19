require 'spec_helper'

module Cb
  describe Cb::TalentNetworkApi do 
    context '.tn_job_information' do 
      it 'should retrieve the tn job information with a good job DID' do 
        valid_did = "JHL5ZF68B66TBD63Z62"
        job_info = Cb.talent_network_api.tn_job_information(valid_did)
        expect(job_info.class).to be == Cb::TalentNetwork::JobInfo
      end
    end

    context '.join_form_questions' do 
      it 'should retrieve the form questions given a valid tn DID' do 
        tn_did = 'CB000000000000000001'
        join_form = Cb.talent_network_api.join_form_questions(tn_did)
        join_form.join_form_questions.size.should > 0
      end

      it 'should not retrieve form questions given a bad tn DID' do 
        tn_did = 'CBTHISISABADDID' 
        # join_form = Cb.talent_network_api.join_form_questions(tn_did)
        # p join_form.inspect
      end
    end

    context '.join_form_branding' do 
      it 'should retrieve branding information for a valid tn DID' do
        tn_did = 'CB000000000000000001'
        join_form_branding_info = Cb.talent_network_api.join_form_branding(tn_did)
        join_form_branding_info.nil?.should == false
      end
    end

    context '.join_form_geography' do 
      it 'should retrieve the geo dropdown list info for join form questions' do 
        join_form_geo = Cb.talent_network_api.join_form_geography
        join_form_geo.nil?.should == false
      
        join_form_geo.countries.geo_hash.length > 0
        join_form_geo.states.geo_hash.length > 0
      end
    end
  end
end