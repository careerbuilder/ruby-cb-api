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
  describe Cb::Requests::Recommendations::Resume do
    describe '#new' do
      let(:headers) do
        {
          'DeveloperKey' => Cb.configuration.dev_key,
          'HostSite' => Cb.configuration.host_site,
          'Content-Type' => 'application/json'
        }
      end
      context 'without arguments' do
        let(:request) { Cb::Requests::Recommendations::Resume.new({}) }

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_recommendation_for_resume.sub(':resume_hash', '') }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq(externalID: nil, countLimit: 25) }
        it { expect(request.body).to eq nil }
        it { expect(request.headers).to eq (headers) }
      end

      context 'with arguments' do
        let (:request) do
          Cb::Requests::Recommendations::Resume.new(resume_hash: 'resumeHash', external_user_id: 'externalUserId')
        end

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_recommendation_for_resume.sub(':resume_hash', 'resumeHash') }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq(externalID: 'externalUserId', countLimit: 25) }
        it { expect(request.body).to eq nil }
        it { expect(request.headers).to eq (headers) }
      end

      context 'when count limit is passed as argument' do
        let (:request) do
          Cb::Requests::Recommendations::Resume.new(resume_hash: 'resumeHash', external_user_id: 'externalUserId', countLimit: 50)
        end

        it { expect(request.query).to eq ({ externalID: 'externalUserId', countLimit: 50 }) }
      end
    end
  end
end
