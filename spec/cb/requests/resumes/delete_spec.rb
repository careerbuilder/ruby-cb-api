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
  describe Cb::Requests::Resumes::Delete do
    context 'initialize without arguments' do
      context 'without arguments' do
        let(:request) { Cb::Requests::Resumes::Delete.new({}) }

        it 'will be correctly configured' do
          expect(request.endpoint_uri).to eq(Cb.configuration.uri_resume_delete.sub(':resume_hash', ''))
          expect(request.http_method).to eq(:delete)
        end

        it 'will have a basic query string' do
          expect(request.query).to eq(externalUserID: nil)
        end

        it 'will have basic headers' do
          expect(request.headers).to eq('DeveloperKey' => Cb.configuration.dev_key,
                                        'HostSite' => Cb.configuration.host_site,
                                        'Content-Type' => 'application/json;version=1.0')
        end

        it 'will have a basic body' do
          expect(request.body).to eq(nil)
        end
      end

      context 'with arguments' do
        let(:request) { Cb::Requests::Resumes::Delete.new(resume_hash: 'resumeHash', external_user_id: 'externalUserId') }

        it 'will be correctly configured' do
          expect(request.endpoint_uri).to eq(Cb.configuration.uri_resume_get.sub(':resume_hash', 'resumeHash'))
          expect(request.http_method).to eq(:delete)
        end

        it 'will have a basic query string' do
          expect(request.query).to eq ({ externalUserID: 'externalUserId' })
        end

        it 'will have basic headers' do
          expect(request.headers).to eq('DeveloperKey' => Cb.configuration.dev_key,
                                        'HostSite' => Cb.configuration.host_site,
                                        'Content-Type' => 'application/json;version=1.0')
        end

        it 'will have a basic body' do
          expect(request.body).to eq(nil)
        end
      end
    end
  end
end
