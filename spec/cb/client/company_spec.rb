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

module CB
  describe CB::Client::Company do
    def stub_api_response_to_return(content)
      stub_request(:get, uri_stem(CB::Client::Company::COMPANY_DETAILS_ENDPOINT))
        .to_return(body: content.to_json)
    end

    let(:client) { CB::Client::Company.new(default_params: { developerkey: '123' }) }

    context '#find_by_did' do
      context 'when the API response has all required nodes' do
        let(:content) do
          {
            Results: {
              CompanyProfileDetail: {
                CompanyPhotos: { PhotoList: [] },
                CompanyBulletinBoard: { bulletinboards: {} },
                Testimonials: { Testimonials: [] },
                CompanyLinksCollection: { companylinks: [] },
                MyContent: { MyContentTabs: [] },
                InfoTabs: { InfoTabs: [] }
              }
            }
          }
        end

        before do
          stub_api_response_to_return(content)
        end

        it 'returns a single company model' do
          res = client.find_by_did('fake-did').parsed_response
          expect(res).to eq(content.to_json)
        end
      end

      context 'when the API response is an empty hash' do
        before { stub_api_response_to_return({}) }

        it 'we get the empty hash' do
          expect(client.find_by_did('fake-did').parsed_response).to eq('{}')
        end
      end
    end
  end
end
