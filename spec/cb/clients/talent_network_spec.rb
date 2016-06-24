# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'spec_helper'

module Cb
  describe Cb::Clients::TalentNetwork do
    context '.tn_job_information' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_tn_job_info))
          .to_return(body: { Response: {} }.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
      end

      it 'should retrieve the tn job information with a good job DID' do
        valid_did = 'JHL5ZF68B66TBD63Z62'
        job_info = Cb.talent_network.tn_job_information(valid_did)
        expect(job_info.class).to be == Cb::Models::TalentNetwork::JobInfo
        expect(job_info.api_error).to eq(false)
      end
    end

    context '.join_form_questions' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_tn_join_questions))
          .to_return(body: { JoinQuestions: [{}] }.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
      end

      it 'should retrieve the form questions given a valid tn DID' do
        tn_did = 'CB000000000000000001'
        join_form = Cb.talent_network.join_form_questions(tn_did)
        expect(join_form.join_form_questions.size).to be > 0
        expect(join_form.api_error).to eq(false)
      end
    end

    context '.join_form_branding' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_tn_join_form_branding))
          .to_return(body: { Branding: {} }.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
      end

      it 'should retrieve branding information for a valid tn DID' do
        tn_did = 'CB000000000000000001'
        join_form_branding_info = Cb.talent_network.join_form_branding(tn_did)
        expect(join_form_branding_info.nil?).to eq(false)
        expect(join_form_branding_info.api_error).to eq(false)
      end
    end

    context '.join_form_geography' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_tn_join_form_geo))
          .to_return(body: { Countries: {}, States: {} }.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
      end

      it 'should retrieve the geo dropdown list info for join form questions' do
        join_form_geo = Cb.talent_network.join_form_geography
        expect(join_form_geo.nil?).to eq(false)

        join_form_geo.countries.geo_hash.length > 0
        join_form_geo.states.geo_hash.length > 0
        expect(join_form_geo.api_error).to eq(false)
      end
    end

    context '.member_create' do
      before :each do
        stub_request(:post, uri_stem(Cb.configuration.uri_tn_member_create))
          .with(body: anything)
          .to_return(body: { Errors: [] }.to_json, headers: { 'content-type' => "application/json;charset=UTF-8"})
      end

      it 'should successfully create a tn member' do
        args1 = {}
        args1['TNDID'] = 'CB000000000000000001'
        args1['JoinValues'] = ['MxDOTalentNetworkMemberInfo_EmailAddress', 'niche_11_test@test.com',
                               'MxDOTalentNetworkMemberInfo_FirstName', 'Niche1',
                               'MxDOTalentNetworkMemberInfo_LastName', 'Tester1',
                               'MxDOTalentNetworkMemberInfo_ZipCode', '30092',
                               'JQJBF32R79L0SH6H3K2D', 'Software Enginner',
                               'ddlCountries', 'us']

        member = Cb.talent_network.member_create(args1)
        expect(member.cb_response.errors.first).not_to eq('EmailInUse')
        expect(member.nil?).not_to eq(true)
        expect(member.api_error).to eq(false)
      end
    end
  end
end
