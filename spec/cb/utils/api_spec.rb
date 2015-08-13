require 'spec_helper'
require_relative '../../support/mocks/observer'
module Cb
  module Utils
    describe Api do
      let(:api) { Api.instance }
      let(:path) { '/moom' }
      let(:options) { {} }

      describe '#factory' do
        it 'returns a new instance of the api class' do
          expect(Cb::Utils::Api.instance).to be_a_kind_of(Cb::Utils::Api)
        end

        context 'when we have observers' do
          before{
            allow(Cb.configuration).to receive(:observers).and_return(Array(Mocks::Observer))
           }
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
          let(:observer) { Mocks::Observer.new }
          before{
            allow(Cb.configuration).to receive(:observers).and_return(Array(Mocks::Observer))
            allow(Api).to receive(:get).with(path, options).and_return(response)
            allow(Mocks::Observer).to receive(:new).and_return(observer)
          }
          it 'will notify the observers' do
            expect(api).to receive(:notify_observers).twice.and_call_original
            expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall), instance_of(Float)).at_most(2).times
            api.cb_get(path)
          end
        end
        it 'sends #get to HttParty' do
          expect(Api).to receive(:get).with(path, options)
          api.cb_get(path)
        end

        context 'When Cb base_uri is configured' do
          before {
            Cb.configuration.base_uri = 'http://www.applecat.com'
            allow(Api).to receive(:get).with(path, options)
          }

          it 'sets base_uri on Api' do
            api.cb_get(path)
            expect(Api.base_uri).to eq 'http://www.applecat.com'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }
          before {
            allow(Api).to receive(:get).with(path, options).and_return(response)
          }

          it 'sends #validate to ResponseValidator with the response' do
            expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
            api.cb_get(path)
          end
        end

      end

      describe '#cb_post' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }
          let(:observer) { Mocks::Observer.new }
          before{
            allow(Cb.configuration).to receive(:observers).and_return(Array(Mocks::Observer))
            allow(Api).to receive(:post).with(path, options).and_return(response)
            allow(Mocks::Observer).to receive(:new).and_return(observer)
          }
          it 'will notify the observers' do
            expect(api).to receive(:notify_observers).twice.and_call_original
            expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall), instance_of(Float)).at_most(2).times
            api.cb_post(path)
          end
        end
        it 'sends #post to HttParty' do
          expect(Api).to receive(:post).with(path, options)
          api.cb_post(path)
        end

        context 'When Cb base_uri is configured' do
          before {
            Cb.configuration.base_uri = 'http://www.bananadog.org'
            allow(Api).to receive(:post).with(path, options)
          }

          it 'sets base_uri on Api' do
            api.cb_post(path)
            expect(Api.base_uri).to eq 'http://www.bananadog.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }
          before {
            allow(Api).to receive(:post).with(path, options).and_return(response)
          }

          it 'sends #validate to ResponseValidator with the response' do
            expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
            api.cb_post(path)
          end
        end

      end

      describe '#cb_put' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }
          let(:observer) { Mocks::Observer.new }
          before{
            allow(Cb.configuration).to receive(:observers).and_return(Array(Mocks::Observer))
            allow(Api).to receive(:put).with(path, options).and_return(response)
            allow(Mocks::Observer).to receive(:new).and_return(observer)
          }
          it 'will notify the observers' do
            expect(api).to receive(:notify_observers).twice.and_call_original
            expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall), instance_of(Float)).at_most(2).times
            api.cb_put(path)
          end
        end
        it 'sends #put to HttParty' do
          expect(Api).to receive(:put).with(path, options)
          api.cb_put(path)
        end

        context 'When Cb base_uri is configured' do
          before {
            Cb.configuration.base_uri = 'http://www.kylerox.org'
            allow(Api).to receive(:put).with(path, options)
          }

          it 'sets base_uri on Api' do
            api.cb_put(path)

            expect(Api.base_uri).to eq 'http://www.kylerox.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }
          before {
            allow(Api).to receive(:put).with(path, options).and_return(response)
          }

          it 'sends #validate to ResponseValidator with the response' do
            expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
            api.cb_put(path)
          end
        end

        end

      describe '#cb_delete' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }
          let(:observer) { Mocks::Observer.new }
          before{
            allow(Cb.configuration).to receive(:observers).and_return(Array(Mocks::Observer))
            allow(Api).to receive(:delete).with(path, options).and_return(response)
            allow(Mocks::Observer).to receive(:new).and_return(observer)
          }
          it 'will notify the observers' do
            expect(api).to receive(:notify_observers).twice.and_call_original
            expect(observer).to receive(:update).with(instance_of(Cb::Models::ApiCall), instance_of(Float)).at_most(2).times
            api.cb_delete(path)
          end
        end
        it 'sends #delete to HttParty' do
          expect(Api).to receive(:delete).with(path, options)
          api.cb_delete(path)
        end

        context 'When Cb base_uri is configured' do
          before {
            Cb.configuration.base_uri = 'http://www.kylerox.org'
            allow(Api).to receive(:delete).with(path, options)
          }

          it 'sets base_uri on Api' do
            api.cb_delete(path)

            expect(Api.base_uri).to eq 'http://www.kylerox.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }
          before {
            allow(Api).to receive(:delete).with(path, options).and_return(response)
          }

          it 'sends #validate to ResponseValidator with the response' do
            expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
            api.cb_delete(path)
          end
        end

      end

      describe '#execute_http_request' do
        context ':delete' do
          context 'when we have observers' do
            let(:response) { { success: 'yeah' } }
            before{
              allow(Cb.configuration).to receive(:observers).and_return(Array(Mocks::Observer))
              allow(Api).to receive(:delete).with(path, options).and_return(response)
            }
            it 'will notify the observers' do
              expect(api).to receive(:notify_observers).twice.and_call_original
              expect_any_instance_of(Mocks::Observer).to receive(:update).at_most(2).times
              api.execute_http_request(:delete, nil, path)
            end
          end
          it 'sends #delete to HttParty' do
            expect(Api).to receive(:delete).with(path, options)
            api.execute_http_request(:delete, nil, path)
          end

          context 'When Cb base_uri is configured' do
            before {
              Cb.configuration.base_uri = 'http://www.kylerox.org'
              allow(Api).to receive(:delete).with(path, options)
            }

            it 'sets base_uri on Api' do
              api.execute_http_request(:delete, nil, path)

              expect(Api.base_uri).to eq 'http://www.kylerox.org'
            end
          end

          context 'When a response is returned' do
            let(:response) { { success: 'yeah' } }
            before {
              allow(Api).to receive(:delete).with(path, options).and_return(response)
            }

            it 'sends #validate to ResponseValidator with the response' do
              expect(ResponseValidator).to receive(:validate).with(response).and_return(response)
              api.execute_http_request(:delete, nil, path)
            end
          end
        end
      end

      describe '#base_uri' do
        let(:base_uri) { 'http://www.careerbuilder.com' }
        let(:default_uri) { 'http://www.kylerox.org' }
        before {
          Cb.configuration.base_uri = default_uri
          allow(Api).to receive(:delete).with(path, options)
        }

        context 'passes a base uri' do
          before {
            api.execute_http_request(:delete, base_uri, path)
          }
          it 'sets an override' do
            expect(Api.base_uri).to eq base_uri
          end
        end

        context 'passes nil' do
          before {
            api.execute_http_request(:delete, nil, path)
          }
          it 'doesn\'t set an override' do
            expect(Api.base_uri).to eq default_uri
          end
        end
      end
    end
  end
end
