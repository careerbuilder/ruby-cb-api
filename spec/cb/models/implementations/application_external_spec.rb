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

module Cb::Models
  describe ApplicationExternal do
    before :all do
      @job_did = 'J1234567890'
      @email = 'dontspammebro@whoa.net'
      @site_id = 'xxx'
      @ipath = 'shivitandshivitgood'
      @is_external_link_apply = true
      @application = ApplicationExternal.new(
        job_did: @job_did,
        email: @email,
        site_id: @site_id,
        is_external_link_apply: @is_external_link_apply,
        ipath: @ipath)
    end

    context '#new' do
      it 'should create an empty new external application' do
        application = ApplicationExternal.new
        expect(application.job_did).to eq ''
        expect(application.email).to eq ''
        expect(application.ipath).to eq ''
        expect(application.is_external_link_apply).to eq false
        expect(application.site_id).to eq 'cbnsv'
        expect(application.apply_url).to eq ''
      end

      it 'should create a populated external application' do
        expect(@application.job_did).to eq @job_did
        expect(@application.email).to eq @email
        expect(@application.ipath).to eq 'shivitands'
        expect(@application.is_external_link_apply).to eq @is_external_link_apply
        expect(@application.site_id).to eq @site_id
        expect(@application.apply_url).to eq ''
      end
    end

    context '#to_xml' do
      it 'returns a string of valid XML' do
        returned_xml = @application.to_xml
        expect(returned_xml).to be_an_instance_of String
      end
    end
  end
end
