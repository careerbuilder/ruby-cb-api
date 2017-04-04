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
  describe Cb::Clients::Job do

    describe '#get' do
      let(:response) { { ResponseJob: inner_nodes }.to_json }
      let(:inner_nodes) { { Job: {} } }

      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_job_find))
          .to_return(body: response)
      end

      let(:args) { { did: 'someDID'} }

      it 'returns a hash' do
        response = Cb::Clients::Job.get(args)
        expect(response).to be_a Hash
      end

      context 'raises an error if errors node contains key phrase' do
        let(:inner_nodes) { { Errors: { Error: 'job was not found' } } }
        it { expect{ Cb::Clients::Job.get(args) }.to raise_error Cb::DocumentNotFoundError }
      end

      context 'not raise an error if errors node does not contain key phrase' do
        let(:inner_nodes) { { Errors: { Error: 'job was found' } } }
        it { expect{ Cb::Clients::Job.get(args) }.not_to raise_error Cb::DocumentNotFoundError }
      end
    end

    describe '#report' do
      subject { Cb::Clients::Job.report(params) }

      let(:headers) do
        {
          'Accept-Encoding' => 'deflate, gzip',
          'Developerkey' => Cb.configuration.dev_key
        }
      end

      let(:params) { { job_id: 'job_id', user_id: 'user_id', report_type: 'report_type', comments: 'comments' } }
      let(:uri) { "https://api.careerbuilder.com/v1/job/report?developerkey=#{ Cb.configuration.dev_key }&outputjson=true" }
      let(:expected_body) do
        <<-eos.gsub /^\s+/, ""
        <Request>
          <DeveloperKey>#{ Cb.configuration.dev_key }</DeveloperKey>
          <JobDID>job_id</JobDID>
          <UserID>user_id</UserID>
          <ReportType>report_type</ReportType>
          <Comments>comments</Comments>
        </Request>
        eos
      end

      let(:stub) do
        stub_request(:post, uri).
          with(headers: headers, body: expected_body).
          to_return(status: 200, body: {}.to_json)
      end


      before do
        stub
        subject
      end

      it { expect(stub).to have_been_requested }
    end
  end
end
