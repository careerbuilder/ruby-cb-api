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
require 'support/mocks/request'
require 'support/mocks/response'
require 'support/mocks/observer'
module Cb
  module Utils
    describe Api do
      let(:api) { Api.instance }
      let(:path) { '/moom' }
      let(:options) { {} }
      let(:observer) { Mocks::Observer.new }

      before do
        allow(Cb.configuration).to receive(:observers).and_return(Array(Mocks::Observer))
        allow(Mocks::Observer).to receive(:new).and_return(observer)
      end

      describe '#factory' do
        it 'returns a new instance of the api class' do
          expect(Cb::Utils::Api.instance).to be_a_kind_of(Cb::Utils::Api)
        end

        context 'when we have observers' do
          it 'returns an instance of Api with the observers attached' do
            expect(Mocks::Observer).to receive(:new)
            expect_any_instance_of(Cb::Utils::Api).to receive(:add_observer)
            expect(Cb::Utils::Api.instance).to be_a_kind_of(Cb::Utils::Api)
          end
        end
      end

      describe '#cb_get' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }

          before do
            allow(Api).to receive(:get).with(path, options).and_return(response)
          end

          it 'will notify the observers' do
            expect(api).to receive(:notify_observers).twice.and_call_original
            expect(Cb::Models::ApiCall).to receive(:new).with(:cb_get_before, '/moom', {},
                                                              { file: __FILE__, method: 'block (4 levels) in <module:Utils>' },
                                                              nil, 0.0).once.and_call_original
            expect(Cb::Models::ApiCall).to receive(:new).with(:cb_get_after, '/moom', {},
                                                              { file: __FILE__, method: 'block (4 levels) in <module:Utils>' },
                                                              { success: 'yeah' }, instance_of(Float)).once.and_call_original
            expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall)).twice
            api.cb_get(path)
          end

          context 'there is an error in the request/response' do
            before do
              allow(Api).to receive(:get).with(path, options).and_raise(StandardError)
            end

            it 'will still notify the observers' do
              expect(api).to receive(:notify_observers).twice.and_call_original
              expect(Cb::Models::ApiCall).to receive(:new).with(:cb_get_before, '/moom', {},
                                                                { file: __FILE__, method: 'block (6 levels) in <module:Utils>' },
                                                                nil, 0.0).once.and_call_original
              expect(Cb::Models::ApiCall).to receive(:new).with(:cb_get_after, '/moom', {},
                                                                { file: __FILE__, method: 'block (6 levels) in <module:Utils>' },
                                                                nil, instance_of(Float)).once.and_call_original
              expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall)).twice
              expect { api.cb_get(path) }.to raise_error(StandardError)
            end
          end

          context 'called from cb/client' do
            before do
              allow(Api).to receive(:get).and_return({})
              allow(Cb::Utils::ResponseMap).to receive(:response_for).and_return(Mocks::Response)
            end

            it 'still identifies the spec file as the caller' do
              expect(Cb::Models::ApiCall).to receive(:new).with(:cb_get_before, instance_of(String), instance_of(Hash),
                                                                { file: __FILE__, method: 'block (5 levels) in <module:Utils>' },
                                                                nil, 0.0).once.and_call_original
              expect(Cb::Models::ApiCall).to receive(:new).with(:cb_get_after, instance_of(String), instance_of(Hash),
                                                                { file: __FILE__, method: 'block (5 levels) in <module:Utils>' },
                                                                {}, instance_of(Float)).once.and_call_original
              expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall)).twice
              Cb::Client.new.execute(Mocks::Request.new(:get))
            end
          end
        end

        it 'sends #get to HttParty' do
          expect(Api).to receive(:get).with(path, options)
          api.cb_get(path)
        end

        context 'When Cb base_uri is configured' do
          before do
            Cb.configuration.base_uri = 'http://www.applecat.com'
            allow(Api).to receive(:get).with(path, options)
          end

          it 'sets base_uri on Api' do
            api.cb_get(path)
            expect(Api.base_uri).to eq 'http://www.applecat.com'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }

          before do
            allow(Api).to receive(:get).with(path, options).and_return(response)
          end

          it 'sends #validate to ResponseValidator with the response' do
            expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
            api.cb_get(path)
          end
        end
      end

      describe '#cb_post' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }

          before do
            allow(Api).to receive(:post).with(path, options).and_return(response)
          end

          it 'will notify the observers' do
            expect(api).to receive(:notify_observers).twice.and_call_original
            expect(Cb::Models::ApiCall).to receive(:new).with(:cb_post_before, '/moom', {},
                                                              { file: __FILE__, method: 'block (4 levels) in <module:Utils>' },
                                                              nil, 0.0).once.and_call_original
            expect(Cb::Models::ApiCall).to receive(:new).with(:cb_post_after, '/moom', {},
                                                              { file: __FILE__, method: 'block (4 levels) in <module:Utils>' },
                                                              { success: 'yeah' }, instance_of(Float)).once.and_call_original
            expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall)).at_most(2).times
            api.cb_post(path)
          end
        end

        it 'sends #post to HttParty' do
          expect(Api).to receive(:post).with(path, options)
          api.cb_post(path)
        end

        context 'When Cb base_uri is configured' do
          before do
            Cb.configuration.base_uri = 'http://www.bananadog.org'
            allow(Api).to receive(:post).with(path, options)
          end

          it 'sets base_uri on Api' do
            api.cb_post(path)
            expect(Api.base_uri).to eq 'http://www.bananadog.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }

          before do
            allow(Api).to receive(:post).with(path, options).and_return(response)
          end

          it 'sends #validate to ResponseValidator with the response' do
            expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
            api.cb_post(path)
          end
        end
      end

      describe '#cb_put' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }

          before do
            allow(Api).to receive(:put).with(path, options).and_return(response)
          end

          it 'will notify the observers' do
            expect(api).to receive(:notify_observers).twice.and_call_original
            expect(Cb::Models::ApiCall).to receive(:new).with(:cb_put_before, '/moom', {},
                                                              { file: __FILE__, method: 'block (4 levels) in <module:Utils>' },
                                                              nil, 0.0).once.and_call_original
            expect(Cb::Models::ApiCall).to receive(:new).with(:cb_put_after, '/moom', {},
                                                              { file: __FILE__, method: 'block (4 levels) in <module:Utils>' },
                                                              { success: 'yeah' }, instance_of(Float)).once.and_call_original
            expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall)).at_most(2).times
            api.cb_put(path)
          end
        end

        it 'sends #put to HttParty' do
          expect(Api).to receive(:put).with(path, options)
          api.cb_put(path)
        end

        context 'When Cb base_uri is configured' do
          before do
            Cb.configuration.base_uri = 'http://www.kylerox.org'
            allow(Api).to receive(:put).with(path, options)
          end

          it 'sets base_uri on Api' do
            api.cb_put(path)

            expect(Api.base_uri).to eq 'http://www.kylerox.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }

          before do
            allow(Api).to receive(:put).with(path, options).and_return(response)
          end

          it 'sends #validate to ResponseValidator with the response' do
            expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
            api.cb_put(path)
          end
        end
      end

      describe '#cb_delete' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }

          before do
            allow(Api).to receive(:delete).with(path, options).and_return(response)
          end

          it 'will notify the observers' do
            expect(api).to receive(:notify_observers).twice.and_call_original
            expect(Cb::Models::ApiCall).to receive(:new).with(:cb_delete_before, '/moom', {},
                                                              { file: __FILE__, method: 'block (4 levels) in <module:Utils>' },
                                                              nil, 0.0).once.and_call_original
            expect(Cb::Models::ApiCall).to receive(:new).with(:cb_delete_after, '/moom', {},
                                                              { file: __FILE__, method: 'block (4 levels) in <module:Utils>' },
                                                              { success: 'yeah' }, instance_of(Float)).once.and_call_original
            expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall)).at_most(2).times
            api.cb_delete(path)
          end
        end

        it 'sends #delete to HttParty' do
          expect(Api).to receive(:delete).with(path, options)
          api.cb_delete(path)
        end

        context 'When Cb base_uri is configured' do
          before do
            Cb.configuration.base_uri = 'http://www.kylerox.org'
            allow(Api).to receive(:delete).with(path, options)
          end

          it 'sets base_uri on Api' do
            api.cb_delete(path)

            expect(Api.base_uri).to eq 'http://www.kylerox.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }

          before do
            allow(Api).to receive(:delete).with(path, options).and_return(response)
          end

          it 'sends #validate to ResponseValidator with the response' do
            expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
            api.cb_delete(path)
          end
        end
      end

      describe '#timed_http_request' do
        context ':delete' do
          context 'when we have observers' do
            let(:response) { { success: 'yeah' } }

            before do
              allow(Api).to receive(:delete).with(path, options).and_return(response)
            end

            it 'will notify the observers' do
              expect(api).to receive(:notify_observers).twice.and_call_original
              expect(observer).to receive(:update).at_most(2).times
              api.timed_http_request(:delete, nil, path)
            end
          end

          it 'sends #delete to HttParty' do
            expect(Api).to receive(:delete).with(path, options)
            api.timed_http_request(:delete, nil, path)
          end

          context 'When Cb base_uri is configured' do
            before do
              Cb.configuration.base_uri = 'http://www.kylerox.org'
              allow(Api).to receive(:delete).with(path, options)
            end

            it 'sets base_uri on Api' do
              api.timed_http_request(:delete, nil, path)

              expect(Api.base_uri).to eq 'http://www.kylerox.org'
            end
          end

          context 'When a response is returned' do
            let(:response) { { success: 'yeah' } }

            before do
              allow(Api).to receive(:delete).with(path, options).and_return(response)
            end

            it 'sends #validate to ResponseValidator with the response' do
              expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
              api.timed_http_request(:delete, nil, path)
            end
          end
        end
      end

      describe '#base_uri' do
        let(:base_uri) { 'http://www.careerbuilder.com' }
        let(:default_uri) { 'http://www.kylerox.org' }

        before do
          Cb.configuration.base_uri = default_uri
          allow(Api).to receive(:delete).with(path, options)
        end

        context 'passes a base uri' do
          before do
            api.timed_http_request(:delete, base_uri, path)
          end

          it 'sets an override' do
            expect(Api.base_uri).to eq base_uri
          end
        end

        context 'passes nil' do
          before do
            api.timed_http_request(:delete, nil, path)
          end

          it 'doesn\'t set an override' do
            expect(Api.base_uri).to eq default_uri
          end
        end
      end
    end
  end
end
