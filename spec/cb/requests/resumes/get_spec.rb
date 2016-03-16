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
  describe Cb::Requests::Resumes::Get do
    let(:headers) do
      {
        'DeveloperKey' => Cb.configuration.dev_key,
        'HostSite' => Cb.configuration.host_site,
        'Content-Type' => 'application/json;version=1.0'
      }
    end
    describe '#new' do
      context 'without arguments' do
        let(:request) { Cb::Requests::Resumes::Get.new({}) }

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_resume_get.sub(':resume_hash', '') }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq(externalUserID: nil) }
        it { expect(request.headers).to eq headers }
        it { expect(request.body).to eq nil }
      end

      context 'with arguments' do
        let (:request) do
          Cb::Requests::Resumes::Get.new(resume_hash: 'resumeHash', external_user_id: 'externalUserId')
        end

        it { expect(request.endpoint_uri).to eq(Cb.configuration.uri_resume_get.sub(':resume_hash', 'resumeHash')) }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq ({ externalUserID: 'externalUserId' }) }
        it { expect(request.headers).to eq headers }
        it { expect(request.body).to eq nil }
      end
    end
  end
end
