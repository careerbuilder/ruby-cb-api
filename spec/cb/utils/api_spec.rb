require 'spec_helper'
require_relative '../../support/mocks/observer'
module Cb
  module Utils
    describe Api do
      let(:api) { Api.new }
      let(:uri) { '/moom' }
      let(:options) { {} }

      describe '#factory' do
        context 'When we have observers' do
          before{
            Cb.configuration.observers.push Mocks::Observer
          }
          it 'we add them to the observers list' do
            Mocks::Observer.should_receive(:new)
            Cb::Utils::Api.any_instance.should_receive(:add_observer)
            Cb::Utils::Api.factory
          end
        end
      end

      describe '#cb_put' do
        context 'when we have observers' do
          it 'notifies the observers' do
            Api.should_receive(:put).with(uri, options)
            Mocks::Observer.any_instance.should_receive(:update)
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
    end
  end
end
