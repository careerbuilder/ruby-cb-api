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
require 'support/mocks/callback'
require 'support/mocks/request'
require 'support/mocks/response'

module Cb
  describe Cb::Client do
    let(:base_uri) { 'www.example.com' }

    context 'initialize' do
      it 'should not use a callback block' do
        client = Cb::Client.new
        expect(client.callback_block).to eq(nil)
      end

      it 'should pass a correct callback' do
        client = Cb::Client.new {}
        expect(client.callback_block.class).to eq(Proc)
      end
    end

    context 'callback' do
      before :each do
        @callback_value = 'copy that ghost rider'
      end

      it 'should call a custom callback method' do
        callback_test = nil
        client = Cb::Client.new { |callback| callback_test = callback }
        client.callback_block.call(@callback_value)
        expect(callback_test).to eq(@callback_value)
      end
    end

    context 'api call no block' do
      let(:mock_api) { double(Cb::Utils::Api) }

      before :each do
        @client = Cb::Client.new
      end

      context 'post' do
        before :each do
          allow(mock_api).to receive(:timed_http_request).and_return({})
          allow(mock_api).to receive(:append_api_responses)
          allow(Cb::Utils::Api).to receive(:new).and_return(mock_api)
          allow(Cb::Utils::ResponseMap).to receive(:response_for).and_return(Mocks::Response)

          @request = Mocks::Request.new(:post)
        end

        it 'should call the api using post' do
          expect(mock_api).to receive(:timed_http_request)
            .with(:post, base_uri, 'parts unknown', query: nil, headers: nil, body: nil)
            .and_return({})

          @client.execute(@request)
        end
      end

      context 'get' do
        before :each do
          allow(mock_api).to receive(:timed_http_request).and_return({})
          allow(mock_api).to receive(:append_api_responses)
          allow(Cb::Utils::Api).to receive(:new).and_return(mock_api)
          allow(Cb::Utils::ResponseMap).to receive(:response_for).and_return(Mocks::Response)

          @request = Mocks::Request.new(:get)
        end

        it 'should call the api using get' do
          expect(mock_api).to receive(:timed_http_request)
            .with(:get, base_uri, 'parts unknown', query: nil, headers: nil, body: nil)
            .and_return({})

          @client.execute(@request)
        end
      end

      context 'put' do
        before :each do
          allow(mock_api).to receive(:timed_http_request).and_return({})
          allow(mock_api).to receive(:append_api_responses)
          allow(Cb::Utils::Api).to receive(:new).and_return(mock_api)
          allow(Cb::Utils::ResponseMap).to receive(:response_for).and_return(Mocks::Response)

          @request = Mocks::Request.new(:put)
        end

        it 'should call the api using put' do
          expect(mock_api).to receive(:timed_http_request)
            .with(:put, base_uri, 'parts unknown', query: nil, headers: nil, body: nil)
            .and_return({})

          @client.execute(@request)
        end
      end
    end
    context 'api call with block' do
      let(:mock_api) { double(Cb::Utils::Api) }

      before :each do
        @client = Cb::Client.new { |a| a }
      end

      context 'post' do
        before :each do
          allow(mock_api).to receive(:timed_http_request).and_return({})
          allow(mock_api).to receive(:append_api_responses)
          allow(Cb::Utils::Api).to receive(:new).and_return(mock_api)
          allow(Cb::Utils::ResponseMap).to receive(:response_for).and_return(Mocks::Response)

          @request = Mocks::Request.new(:post)
        end

        it 'should call the api using post' do
          expect(mock_api).to receive(:timed_http_request)
            .with(:post, base_uri, 'parts unknown', query: nil, headers: nil, body: nil)
            .and_yield('test')
            .and_return({})

          @client.execute(@request)
        end
      end

      context 'get' do
        before :each do
          allow(mock_api).to receive(:timed_http_request).and_return({})
          allow(mock_api).to receive(:append_api_responses)
          allow(Cb::Utils::Api).to receive(:new).and_return(mock_api)
          allow(Cb::Utils::ResponseMap).to receive(:response_for).and_return(Mocks::Response)

          @request = Mocks::Request.new(:get)
        end

        it 'should call the api using get' do
          expect(mock_api).to receive(:timed_http_request)
            .with(:get, base_uri, 'parts unknown', query: nil, headers: nil, body: nil)
            .and_yield('test')
            .and_return({})

          @client.execute(@request)
        end
      end

      context 'put' do
        before :each do
          allow(mock_api).to receive(:timed_http_request).and_return({})
          allow(mock_api).to receive(:append_api_responses)
          allow(Cb::Utils::Api).to receive(:new).and_return(mock_api)
          allow(Cb::Utils::ResponseMap).to receive(:response_for).and_return(Mocks::Response)

          @request = Mocks::Request.new(:put)
        end

        it 'should call the api using put' do
          expect(mock_api).to receive(:timed_http_request)
            .with(:put, base_uri, 'parts unknown', query: nil, headers: nil, body: nil)
            .and_yield('test')
            .and_return({})

          @client.execute(@request)
        end
      end
    end
  end
end
