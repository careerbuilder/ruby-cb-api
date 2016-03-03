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
  describe Cb::Clients::ApplicationExternal do
    context '#submit_app' do
      context 'when the parameter not the correct type' do
        it 'should raise a Cb::IncomingParamIsWrongTypeException' do
          expect { Cb.application_external.submit_app(Object.new) }.to raise_error Cb::IncomingParamIsWrongTypeException
        end
      end

      def stub_api_call_to_return(body_content)
        stub_request(:post, uri_stem(Cb.configuration.uri_application_external)).with(body: anything)
          .to_return(body: body_content.to_json)
      end

      def submit_app(app)
        Cb::Clients::ApplicationExternal.submit_app(app)
      end

      context 'when everything is working correctly' do
        let(:external_app) { Cb::Models::ApplicationExternal.new(job_did: 'did',
                                                                 email: 'bogus@bogus.org',
                                                                 ipath: 'bogus',
                                                                 site_id: 'bogus') }

        it 'the same application object is returned that is supplied for input' do
          stub_api_call_to_return({})
          app = submit_app(external_app)
          expect(app).to eq external_app
          expect(app.object_id).to eq external_app.object_id
        end

        context 'if the ApplyUrl field comes back in the response' do
          before(:each) { stub_api_call_to_return('ApplyUrl' => 'https://bacondreamz.net') }

          it 'the ApplyUrl is set on the returned app' do
            app = submit_app(external_app)
            expect(app.apply_url).to eq 'https://bacondreamz.net'
          end
        end

        context 'if the ApplyUrl field is not in the response' do
          before(:each) { stub_api_call_to_return({}) }

          it 'the ApplyUrl on the returned app is blank' do
            app = submit_app(external_app)
            expect(app.apply_url.empty?).to eq true
          end
        end

        context 'when posting to the API' do
          it 'posts the application as xml' do
            stub_request(:post, uri_stem(Cb.configuration.uri_application_external))
                .with(body: external_app.to_xml)
            submit_app(external_app)
          end
        end
      end
    end
  end
end
