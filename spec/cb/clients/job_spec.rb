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
    describe '#search' do
      context 'when the search returns with no results' do
        before(:each) do
          content = { ResponseJobSearch: {} }

          stub_request(:get, uri_stem(Cb.configuration.uri_job_search))
            .to_return(body: content.to_json)
        end

        it 'returns an empty array' do
          response = Cb.job.search({})
          expect(response.model.jobs.count).to eq(0)
        end
      end

      context 'when the search returns a location conflict' do
        before(:each) do
          content = { ResponseJobSearch: {
            'Results' => {
              'LocationConflict' => {
                'Location' => 'Atlantica Aeneas Hotel, CY',
                'Location' => 'Atlantica Miramare Beach, CY',
                'Location' => 'Atlantica Sungarden Beach Hotel, CY'
              }
            }
          }
                    }

          stub_request(:get, uri_stem(Cb.configuration.uri_job_search))
            .to_return(body: content.to_json)
        end

        it 'returns an empty array' do
          response = Cb.job.search({})
          expect(response.model.jobs.count).to eq(0)
        end
      end

      context 'when the search returns with results' do
        before(:each) do
          content = { ResponseJobSearch: {
            SearchMetaData: { SearchLocations: { SearchLocation: ['tahiti'] } },
            Results: { JobSearchResult: [{}] } } }

          stub_request(:get, uri_stem(Cb.configuration.uri_job_search))
            .to_return(body: content.to_json)
        end

        it 'returns an array of job models' do
          response = Cb.job.search({})
          expect(response.model.jobs[0].is_a?(Cb::Models::Job)).to eq(true)
        end
      end

      context 'When the search returns only one result' do
        before(:each) do
          content = {
            ResponseJobSearch: {
              SearchMetaData: { SearchLocations: { SearchLocation: ['tahiti'] } },
              Results: { JobSearchResult: {} }
            }
          }
          stub_request(:get, uri_stem(Cb.configuration.uri_job_search)).to_return(body: content.to_json)
        end

        it 'returns an array of job models' do
          search = Cb.job.search({})
          expect(search.model.jobs[0]).to be_a Cb::Models::Job
        end
      end

      context 'When the search returns with collapsed results' do
        let(:search) { Cb.job.search({}) }
        let(:content) { JSON.parse(File.read('spec/support/response_stubs/collapsed_search.json')) }

        before do
          stub_request(:get, uri_stem(Cb.configuration.uri_job_search)).to_return(body: content.to_json)
        end

        it { expect(search.model).to be_a Cb::Models::CollapsedJobResults }
        it { expect(search.model.grouped_jobs[0].job_description).to be_a Cb::Models::Job }
        it { expect(search.model.grouped_jobs[0].grouping_value).to eq '123321' }
        it { expect(search.model.grouped_jobs[0].job_count).to eq 1 }
        it { expect(search.model.grouped_jobs[0].job).to eq search.model.grouped_jobs[0].job_description  }
      end

      context 'When the search returns with 1 collapsed result and CB Serialization' do
        let(:search) { Cb.job.search({}) }
        let(:content) { JSON.parse(File.read('spec/support/response_stubs/single_result_in_collapsed_search_with_CB_serialization.json')) }
        let(:grouped_jobs) { search.model.grouped_jobs[0] }

        before do
          stub_request(:get, uri_stem(Cb.configuration.uri_job_search)).to_return(body: content.to_json)
        end

        it { expect(search.model).to be_a Cb::Models::CollapsedJobResults }
        it { expect(grouped_jobs.job_description).to be_a Cb::Models::Job }
        it { expect(grouped_jobs.grouping_value).to eq '123321' }
        it { expect(grouped_jobs.job_count).to eq 1 }
        it { expect(grouped_jobs.job).to eq grouped_jobs.job_description  }
      end
    end

    describe '#find_by_criteria' do
      before :each do
        stub_request(:get, uri_stem(Cb.configuration.uri_job_find))
          .to_return(body: { ResponseJob: { Job: {} } }.to_json)
      end

      let(:criteria) { Cb::Criteria::Job::Details.new }

      context 'when a criteria object is the input param' do
        it 'returns a single job model' do
          response = Cb::Clients::Job.find_by_criteria(criteria)
          expect(response.model).to be_an_instance_of Cb::Models::Job
        end

        it 'returns a single job model' do
          response = Cb::Clients::Job.find_by_criteria(criteria)
          expect(response.model).to be_an_instance_of Cb::Models::Job
        end
      end
    end

    context '#find_by_did' do
      context 'when a string job did is input' do
        let(:criteria) { double(Cb::Criteria::Job::Details) }

        before(:each) { allow(Cb::Criteria::Job::Details).to receive(:new).and_return(criteria) }

        it 'constructs a criteria object, sets the input did, and calls #find_by_criteria' do
          did = 'fake-did'

          expect(Cb::Clients::Job).to receive(:find_by_criteria).with(criteria)
          expect(criteria).to receive(:did=).with(did)
          expect(criteria).to receive(:show_custom_values=).with(true)

          Cb::Clients::Job.find_by_did(did)
        end
      end
    end
  end
end
