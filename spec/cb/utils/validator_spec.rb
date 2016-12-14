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
  describe ResponseValidator do
    let(:response)          { double(HTTParty::Response, response: response_property, code: response_code) }
    let(:response_property) { double('HTTParty::Response.response', body: response_body) }
    let(:response_body)     { nil }
    let(:response_code)     { 200 }

    subject(:validation) { ResponseValidator.validate(response) }

    context 'with an empty body' do
      let(:response_body) { '' }

      it 'returns an empty hash' do
        expect(validation).to be_empty
      end
    end

    context 'with an invalid body' do
      let(:response_body) { 'json' }

      it 'returns an empty hash' do
        expect(validation).to be_empty
      end
    end

    context 'with a nil body' do
      let(:response_body) { nil }

      it 'returns an empty hash' do
        expect(validation).to be_empty
      end
    end

    context 'with an unsuccessful response status' do
      let(:response_code) { 500 }
      let(:response_body) { '{"errors":["Something went terribly wrong."]}' }

      it 'populates error message from the json response' do
        expect { validation }.to raise_error do |error|
          expect(error.message).to eq '["Something went terribly wrong."]'
          expect(error).to be_a Cb::ServerError
        end
      end

      it { expect { validation }.to raise_error(Cb::ServerError) }

      context 'of 400' do
        let(:response_code) { 400 }

        it { expect { validation }.to raise_error(Cb::BadRequestError) }
      end

      context 'of 401' do
        let(:response_code) { 401 }

        it { expect { validation }.to raise_error(Cb::UnauthorizedError) }
      end

      context 'of 404' do
        let(:response_code) { 404 }

        it { expect { validation }.to raise_error(Cb::DocumentNotFoundError) }
      end

      context 'of 503' do
        let(:response_code) { 503 }

        it { expect { validation }.to raise_error(Cb::ServiceUnavailableError) }
      end

      context 'with valid json content' do
        let(:response_body) { '{"TestJson":{"Test":"True"}}' }

        it 'returns the parsed json on the exception' do
          expect { validation }.to raise_error do |error|
            expect(error.response).to be_a Hash
            expect(error.response).to have_key 'TestJson'
            expect(error.response['TestJson']).to eq({ 'Test' => 'True' })
          end
        end
      end

      context 'with html content' do
        let(:response_body) { '<!DOCTYPE html></html>' }

        it 'returns an empty hash on the exception' do
          expect { validation }.to raise_error do |error|
            expect(error.response).to be_empty
          end
        end
      end

      context 'with a capital E in errors' do
        let(:response_body) { '{"Errors":["Something went terribly wrong."]}' }

        it 'populates error message from the json response' do
          expect { validation }.to raise_error do |error|
            expect(error.message).to eq '["Something went terribly wrong."]'
            expect(error).to be_a Cb::ServerError
          end
        end
      end

      context 'when the errors node is inside ResponseUserCreate' do
        let(:response_body)  { '{"ResponseUserCreate":{ "Errors" : "Everything broke" }}' }

        it 'sets the error message to the value of the errors node' do
          expect { validation }.to raise_error do |error|
            expect(error.message).to eq 'Everything broke'
          end
        end
      end
    end

    context 'when there are json parsing errors' do
      before do
        allow(JSON).to receive(:parse).and_raise JSON::ParserError
      end

      context 'with an XML body' do
        let(:response_body) { '<yo><this><isxml>yay</isxml></this></yo>' }

        it 'returns a hash of the XML' do
          expect(validation).to eq({ 'yo' => { 'this' => { 'isxml' => 'yay' } } })
        end
      end

      context 'with a non-XML body' do
        let(:response_body) { 'yay not json' }

        it 'returns an empty hash' do
          expect(validation).to be_empty
        end
      end
    end

    context 'when SIMULATE_AUTH_OUTAGE flag is enabled' do
      before do
        allow(ENV).to receive(:[]).with('SIMULATE_AUTH_OUTAGE').and_return true
      end

      it { expect { validation }.to raise_error(Cb::ServiceUnavailableError) }
    end
  end
end
