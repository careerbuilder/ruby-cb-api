require 'spec_helper'
require_relative '../../support/mocks/observer'
module Cb
  module Utils
    describe Api do
      let(:api) { Api.instance }
      let(:uri) { '/moom' }
      let(:options) { {} }

      describe '#factory' do
        it 'returns a new instance of the api class' do
          expect(Cb::Utils::Api.instance).to be_a_kind_of(Cb::Utils::Api)
        end

        context 'when we have observers' do
          before{
            Cb.configuration.stub(:observers).and_return(Array(Mocks::Observer))
           }
          it 'returns an instance of Api with the observers attached' do
            Mocks::Observer.should_receive(:new)
            Cb::Utils::Api.any_instance.should_receive(:add_observer)
            expect(Cb::Utils::Api.instance).to be_a_kind_of(Cb::Utils::Api)
          end
        end
      end

      describe '#cb_get' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }
          before{
            Cb.configuration.stub(:observers).and_return(Array(Mocks::Observer))
            Api.stub(:get).with(uri, options).and_return(response)
          }
          it 'will notify the observers' do
            api.should_receive(:notify_observers).twice.and_call_original
            Mocks::Observer.any_instance.should_receive(:update).at_most(2).times
            api.cb_get(uri)
          end
        end
        it 'sends #post to HttParty' do
          Api.should_receive(:get).with(uri, options)
          api.cb_get(uri)
        end

        context 'When Cb base_uri is configured' do
          before {
            Cb.configuration.base_uri = 'http://www.applecat.com'
            Api.stub(:get).with(uri, options)
          }

          it 'sets base_uri on Api' do
            api.cb_get(uri)
            expect(Api.base_uri).to eq 'http://www.applecat.com'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }
          before {
            Api.stub(:get).with(uri, options).and_return(response)
          }

          it 'sends #validate to ResponseValidator with the response' do
            ResponseValidator.should_receive(:validate).with(response).and_return(response)
            api.cb_get(uri)
          end
        end

      end

      describe '#cb_post' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }
          before{
            Cb.configuration.stub(:observers).and_return(Array(Mocks::Observer))
            Api.stub(:post).with(uri, options).and_return(response)
          }
          it 'will notify the observers' do
            api.should_receive(:notify_observers).twice.and_call_original
            Mocks::Observer.any_instance.should_receive(:update).at_most(2).times
            api.cb_post(uri)
          end
        end
        it 'sends #post to HttParty' do
          Api.should_receive(:post).with(uri, options)
          api.cb_post(uri)
        end

        context 'When Cb base_uri is configured' do
          before {
            Cb.configuration.base_uri = 'http://www.bananadog.org'
            Api.stub(:post).with(uri, options)
          }

          it 'sets base_uri on Api' do
            api.cb_post(uri)
            expect(Api.base_uri).to eq 'http://www.bananadog.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }
          before {
            Api.stub(:post).with(uri, options).and_return(response)
          }

          it 'sends #validate to ResponseValidator with the response' do
            ResponseValidator.should_receive(:validate).with(response).and_return(response)
            api.cb_post(uri)
          end
        end

      end

      describe '#cb_put' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }
          before{
            Cb.configuration.stub(:observers).and_return(Array(Mocks::Observer))
            Api.stub(:put).with(uri, options).and_return(response)
          }
          it 'will notify the observers' do
            api.should_receive(:notify_observers).twice.and_call_original
            Mocks::Observer.any_instance.should_receive(:update).at_most(2).times
            api.cb_put(uri)
          end
        end
        it 'sends #put to HttParty' do
          Api.should_receive(:put).with(uri, options)
          api.cb_put(uri)
        end

        context 'When Cb base_uri is configured' do
          before {
            Cb.configuration.base_uri = 'http://www.kylerox.org'
            Api.stub(:put).with(uri, options)
          }

          it 'sets base_uri on Api' do
            api.cb_put(uri)

            expect(Api.base_uri).to eq 'http://www.kylerox.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }
          before {
            Api.stub(:put).with(uri, options).and_return(response)
          }

          it 'sends #validate to ResponseValidator with the response' do
            ResponseValidator.should_receive(:validate).with(response).and_return(response)
            api.cb_put(uri)
          end
        end

        end

      describe '#cb_delete' do
        context 'when we have observers' do
          let(:response) { { success: 'yeah' } }
          before{
            Cb.configuration.stub(:observers).and_return(Array(Mocks::Observer))
            Api.stub(:delete).with(uri, options).and_return(response)
          }
          it 'will notify the observers' do
            api.should_receive(:notify_observers).twice.and_call_original
            Mocks::Observer.any_instance.should_receive(:update).at_most(2).times
            api.cb_delete(uri)
          end
        end
        it 'sends #delete to HttParty' do
          Api.should_receive(:delete).with(uri, options)
          api.cb_delete(uri)
        end

        context 'When Cb base_uri is configured' do
          before {
            Cb.configuration.base_uri = 'http://www.kylerox.org'
            Api.stub(:delete).with(uri, options)
          }

          it 'sets base_uri on Api' do
            api.cb_delete(uri)

            expect(Api.base_uri).to eq 'http://www.kylerox.org'
          end
        end

        context 'When a response is returned' do
          let(:response) { { success: 'yeah' } }
          before {
            Api.stub(:delete).with(uri, options).and_return(response)
          }

          it 'sends #validate to ResponseValidator with the response' do
            ResponseValidator.should_receive(:validate).with(response).and_return(response)
            api.cb_delete(uri)
          end
        end

      end

      describe '#http_request' do
        context ':delete' do
          context 'when we have observers' do
            let(:response) { { success: 'yeah' } }
            before{
              Cb.configuration.stub(:observers).and_return(Array(Mocks::Observer))
              Api.stub(:delete).with(uri, options).and_return(response)
            }
            it 'will notify the observers' do
              api.should_receive(:notify_observers).twice.and_call_original
              Mocks::Observer.any_instance.should_receive(:update).at_most(2).times
              api.http_request(:delete, uri)
            end
          end
          it 'sends #delete to HttParty' do
            Api.should_receive(:delete).with(uri, options)
            api.http_request(:delete, uri)
          end

          context 'When Cb base_uri is configured' do
            before {
              Cb.configuration.base_uri = 'http://www.kylerox.org'
              Api.stub(:delete).with(uri, options)
            }

            it 'sets base_uri on Api' do
              api.http_request(:delete, uri)

              expect(Api.base_uri).to eq 'http://www.kylerox.org'
            end
          end

          context 'When a response is returned' do
            let(:response) { { success: 'yeah' } }
            before {
              Api.stub(:delete).with(uri, options).and_return(response)
            }

            it 'sends #validate to ResponseValidator with the response' do
              ResponseValidator.should_receive(:validate).with(response).and_return(response)
              api.http_request(:delete, uri)
            end
          end
        end
      end




    end
  end
end
