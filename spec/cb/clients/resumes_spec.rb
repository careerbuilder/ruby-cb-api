# Copyright 2016 CareerBuilder, LLC
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
  describe Cb::Clients::Resumes do
    let(:headers) do
      {
        'Accept-Encoding' => 'deflate, gzip',
        'Authorization' => 'Bearer token',
        'Content-Type' => 'application/json;version=1.0',
        'Developerkey' => Cb.configuration.dev_key,
        'HostSite' =>'US'
      }
    end

    describe '#get' do
      subject { Cb::Clients::Resumes.get(oauth_token: 'token') }

      let(:uri) { "https://api.careerbuilder.com/consumer/resumes?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
      let(:api_response) { JSON.parse File.read('spec/support/response_stubs/resumes.json') }
      let(:stub) do
        stub_request(:get, uri).
          with(headers: headers).
          to_return(status: 200, body: api_response.to_json)
      end


      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }
      it { is_expected.to eq api_response }

      context 'When given a site' do
        let(:expected_additional_param) { 'site=US' }
        let(:uri) { "https://api.careerbuilder.com/consumer/resumes?developerkey=#{ Cb.configuration.dev_key }&outputjson=true&#{ expected_additional_param }" }

        subject { Cb::Clients::Resumes.get(site: 'US', oauth_token: 'token') }

        it { expect(stub).to have_been_requested }
        it { is_expected.to eq api_response }
      end
    end

    describe '#post' do
      subject { Cb::Clients::Resumes.post(oauth_token: 'token', desired_job_title: 'Ur Mom', privacy_setting: 'Public', resume_file_data: 'DATA', resume_file_name: 'UrMom.doc', host_site: 'US', entry_path: 'WAT') }

      let(:url) { "https://api.careerbuilder.com/consumer/resumedocuments?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
      let(:expected_body) do
        "{\"desiredJobTitle\":\"Ur Mom\",\"privacySetting\":\"Public\",\"resumeFileData\":\"DATA\",\"resumeFileName\":\"UrMom.doc\",\"hostSite\":\"US\",\"entryPath\":\"WAT\"}"
      end

      let(:stub) do
        stub_request(:post, url).
          with(headers: headers, body: expected_body).
          to_return(status: 200, body: {}.to_json)
      end

      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }
    end

    describe '#delete' do
      subject { Cb::Clients::Resumes.delete(oauth_token: 'token', resume_hash: 'scattered_smothered_covered', external_user_id: 'Ext') }

      let(:url) { "https://api.careerbuilder.com/cbapi/resumes/scattered_smothered_covered?developerkey=#{ Cb.configuration.dev_key }&externalUserId=Ext&outputjson=true" }

      let(:stub) do
        stub_request(:delete, url).
          with(headers: headers).
          to_return(status: 200, body: {}.to_json)
      end

      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }
    end

    describe '#put' do
      subject { Cb::Clients::Resumes.put(params) }

      let(:url) { "https://api.careerbuilder.com/cbapi/resumes/scattered_smothered_covered?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
      let(:expected_body) do
        '{"userIdentifier":"Thing","resumeHash":"scattered_smothered_covered","desiredJobTitle":"Ur Mom","privacySetting":"Public","workExperience":[],"salaryInformation":{},"educations":[],"skillsAndQualifications":{},"relocations":[],"governmentAndMilitary":{}}'
      end
      let(:params) { { user_identifier: 'Thing', oauth_token: 'token', desired_job_title: 'Ur Mom', privacy_setting: 'Public', host_site: 'US', resume_hash: 'scattered_smothered_covered' } }

      let(:stub) do
        stub_request(:put, url).
          with(headers: headers, body: expected_body).
          to_return(status: 200, body: {}.to_json)
      end

      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }

      context 'with resume data' do
        let(:params) do
          {
            user_identifier: 'Thing',
            oauth_token: 'token',
            desired_job_title: 'Ur Mom',
            privacy_setting: 'Public',
            host_site: 'US',
            resume_hash: 'scattered_smothered_covered',
            work_experience: [{
              job_title: 'King',
              company_name: 'Waffle House',
              employment_type: 'Royal',
              start_date: 'Beginning of Time',
              end_date: 'Present',
              currently_employed_here: true,
              id: 1337
            }],
            salary_information: {
              most_recent_pay_amount: '100 million',
              per_hour_or_per_year: 'per_year',
              current_code: 'USD',
              work_experience_id: 1337,
              annual_bonus: 'infinite',
              annual_commission: 'hash browns'
            },
            educations: [{
              school_name: 'School of Hard Knocks',
              major_or_program: 'Life',
              degree: 'Yes',
              graduation_date: 'Ongoing'
            }],
            skills_and_qualifications: {
              accreditations_and_certifications: 'All',
              languages_spoken: 'Elvish, Elvisish',
              has_management_experience: 'Yes',
              size_of_team_managed: '6 billion'
            },
            relocations: [{
              city: 'The Moon',
              admin_area: 'The Moon',
              country_code: 'MOON'
            }],
            government_and_military: {
              has_security_clearance: true,
              military_experience: 'commander in chief'
            }
          }
        end

        let(:expected_body) { "{\"userIdentifier\":\"Thing\",\"resumeHash\":\"scattered_smothered_covered\",\"desiredJobTitle\":\"Ur Mom\",\"privacySetting\":\"Public\",\"workExperience\":[{\"jobTitle\":\"King\",\"companyName\":\"Waffle House\",\"employmentType\":\"Royal\",\"startDate\":\"Beginning of Time\",\"endDate\":\"Present\",\"currentlyEmployedHere\":true,\"id\":1337}],\"salaryInformation\":{\"mostRecentPayAmount\":\"100 million\",\"perHourOrPerYear\":\"per_year\",\"currencyCode\":null,\"workExperienceId\":1337,\"annualBonus\":\"infinite\",\"annualCommission\":\"hash browns\"},\"educations\":[{\"schoolName\":\"School of Hard Knocks\",\"majorOrProgram\":\"Life\",\"degree\":\"Yes\",\"graduationDate\":\"Ongoing\"}],\"skillsAndQualifications\":{\"accreditationsAndCertifications\":\"All\",\"languagesSpoken\":\"Elvish, Elvisish\",\"hasManagementExperience\":\"Yes\",\"sizeOfTeamManaged\":\"6 billion\"},\"relocations\":[{\"city\":\"The Moon\",\"adminArea\":\"The Moon\",\"countryCode\":\"MOON\"}],\"governmentAndMilitary\":{\"hasSecurityClearance\":true,\"militaryExperience\":\"commander in chief\"}}" }

        it { expect(stub).to have_been_requested }
      end
    end
  end
end
