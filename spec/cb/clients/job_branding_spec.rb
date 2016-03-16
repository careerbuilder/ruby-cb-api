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
  describe Cb::Clients::JobBranding do
    context '.find_by_id' do
      before :each do
        content = { Branding: { Media: {}, Sections: [], Widgets: {}, Styles: {
          Page: nil, JobDetails: { Container: nil, Content: nil, Headings: nil },
          CompanyInfo: { Buttons: nil, Container: nil, Content: nil, Headings: nil } } } }

        stub_request(:get, uri_stem(Cb.configuration.uri_job_branding))
          .to_return(body: content.to_json)
      end

      it 'should return valid job branding schema' do
        job_branding = Cb::Clients::JobBranding.find_by_id('fake-id')
        expect(job_branding).to be_an_instance_of Cb::Models::JobBranding
      end
    end
  end
end
