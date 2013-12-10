require 'spec_helper'

module Cb
  describe Cb::Clients::TalentNetwork do
    context '.tn_job_information' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_tn_job_info)).
          to_return(:body => { Response: Hash.new }.to_json)
      end

      it 'should retrieve the tn job information with a good job DID' do 
        valid_did = "JHL5ZF68B66TBD63Z62"
        job_info = Cb.talent_network.tn_job_information(valid_did)
        expect(job_info.class).to be == Cb::Models::TalentNetwork::JobInfo
        job_info.api_error.should == false
      end
    end

    context '.join_form_questions' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_tn_join_questions)).
          to_return(:body => { JoinQuestions: [Hash.new] }.to_json)
      end

      it 'should retrieve the form questions given a valid tn DID' do 
        tn_did = 'CB000000000000000001'
        join_form = Cb.talent_network.join_form_questions(tn_did)
        join_form.join_form_questions.size.should > 0
        join_form.api_error.should == false
      end
    end

    context '.join_form_branding' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_tn_join_form_branding)).
          to_return(:body => { Branding: Hash.new }.to_json)
      end

      it 'should retrieve branding information for a valid tn DID' do
        tn_did = 'CB000000000000000001'
        join_form_branding_info = Cb.talent_network.join_form_branding(tn_did)
        join_form_branding_info.nil?.should == false
        join_form_branding_info.api_error.should == false
      end
    end

    context '.join_form_geography' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_tn_join_form_geo)).
          to_return(:body => { Countries: Hash.new, States: Hash.new }.to_json)
      end

      it 'should retrieve the geo dropdown list info for join form questions' do 
        join_form_geo = Cb.talent_network.join_form_geography
        join_form_geo.nil?.should == false
      
        join_form_geo.countries.geo_hash.length > 0
        join_form_geo.states.geo_hash.length > 0
        join_form_geo.api_error.should == false
      end
    end

    context '.member_create' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_tn_member_create)).
          with(:body => anything).
          to_return(:body => { Errors: Array.new }.to_json)
      end

      it 'should successfully create a tn member' do
        args1 = Hash.new
        args1['TNDID'] = 'CB000000000000000001'
        args1['JoinValues'] = ["MxDOTalentNetworkMemberInfo_EmailAddress", "niche_11_test@test.com",
                              "MxDOTalentNetworkMemberInfo_FirstName","Niche1",
                                "MxDOTalentNetworkMemberInfo_LastName", "Tester1",
                                  "MxDOTalentNetworkMemberInfo_ZipCode","30092",
                                  "JQJBF32R79L0SH6H3K2D","Software Enginner",
                                  "ddlCountries","us"]

        member = Cb.talent_network.member_create(args1)
        member.cb_response.errors.first.should_not == "EmailInUse"
        member.nil?.should_not == true
        member.api_error.should == false
      end

    end
  end
end
