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
  describe Responses::Education::Get do
    let(:json_hash) do
      {
        'ResponseEducationCodes' => {
          'Errors' => nil,
          'CountryCode' => 'US',
          'TimeResponseSent' => '6/2/2014 10:32:44 AM',
          'EducationCodes' => {
            'Education' => [
              {
                'Code' => 'DRNS', 'Name' => { '@language' => 'en-US', '#text' => 'Not Specified' }
              },
              {
                'Code' => 'DR3210', 'Name' => { '@language' => 'en-US', '#text' => 'None' }
              },
              {
                'Code' => 'DR3211', 'Name' => { '@language' => 'en-US', '#text' => 'High School' }
              }
            ]
          }
        }
      }
    end

    context '#new' do
      it 'returns a response object with a filled in model' do
        expect(Responses::Education::Get.new(json_hash).class).to eq Responses::Education::Get
      end

      it 'instantiates new model objects' do
        models = Responses::Education::Get.new(json_hash).models

        expect(models[0].class).to eq(Cb::Models::Education)

        expect(models.length).to eq(3)

        expect(models[0].code).to eq('DRNS')
        expect(models[0].text).to eq('Not Specified')
        expect(models[0].language).to eq('en-US')

        expect(models[1].code).to eq('DR3210')
        expect(models[1].text).to eq('None')
        expect(models[1].language).to eq('en-US')

        expect(models[2].code).to eq('DR3211')
        expect(models[2].text).to eq('High School')
        expect(models[2].language).to eq('en-US')
      end
    end
  end
end
