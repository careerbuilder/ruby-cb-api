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
require 'support/mocks/oauth_token'

module Cb
  describe Cb::Clients::Recommendations do
    context '.for_job' do
      before do
        stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_job))
          .to_return(body: { ResponseRecommendJob: { Request: { RequestEvidenceID: 'abc-123' }, RecommendJobResults: { RecommendJobResult: [{ did: 1 }, { did: 2 }] }, Errors: ['Error1', 'Error2'] } }.to_json)
      end

      subject(:recs) { Cb::Clients::Recommendations.for_job('fake-did') }

      it { is_expected.to be_a Hash }
      it { expect(recs[:errors]).to eq ['Error1', 'Error2'] }
      it { expect(recs[:recid]).to eq 'abc-123' }
      it { expect(recs[:jobs].count).to eq 2 }
      it { expect(recs[:jobs]).to all(be_a Cb::Models::Job) }

      context 'with a single hash result' do
        before do
          stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_job))
            .to_return(body: { ResponseRecommendJob: { Request: { RequestEvidenceID: 'abc-123' }, RecommendJobResults: { RecommendJobResult: { did: 1 } }, Errors: ['Error1', 'Error2'] } }.to_json)
        end

        it { expect(recs[:jobs]).to be_an Array }

      end

      context 'with no recs' do
        before do
          stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_job))
            .to_return(body: { ResponseRecommendJob: { Request: { RequestEvidenceID: 'abc-123' }, Errors: ['Error1', 'Error2'] } }.to_json)
        end

        it { expect{ recs }.not_to raise_error }

      end
    end

    context '.for_user' do
      before do
        stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_user))
          .to_return(body: { ResponseRecommendUser: { Request: { RequestEvidenceID: 'abc-123' }, RecommendJobResults: { RecommendJobResult: [{ did: 1 }, { did: 2 }] }, Errors: ['Error1', 'Error2'] } }.to_json)
      end

      subject(:recs) { Cb::Clients::Recommendations.for_user('U1234') }

      it { is_expected.to be_a Hash }
      it { expect(recs[:errors]).to eq ['Error1', 'Error2'] }
      it { expect(recs[:recid]).to eq 'abc-123' }
      it { expect(recs[:jobs].count).to eq 2 }
      it { expect(recs[:jobs]).to all(be_a Cb::Models::Job) }

      context 'with a single hash result' do
        before do
          stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_user))
          .to_return(body: { ResponseRecommendUser: { Request: { RequestEvidenceID: 'abc-123' }, RecommendJobResults: { RecommendJobResult: { did: 1 } }, Errors: ['Error1', 'Error2'] } }.to_json)
        end

        it { expect(recs[:jobs]).to be_an Array }
      end

      context 'with no recs' do
        before do
          stub_request(:get, uri_stem(Cb.configuration.uri_recommendation_for_job))
            .to_return(body: { ResponseRecommendUser: { Request: { RequestEvidenceID: 'abc-123' }, Errors: ['Error1', 'Error2'] } }.to_json)
        end

        it { expect{ recs }.not_to raise_error }

      end
    end
  end
end
