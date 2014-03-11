require 'spec_helper'

module Cb
  module Utils
    describe Api do
      let(:api) { Api.new }
      let(:uri) { '/moom' }
      let(:options) { {} }

      describe '#cb_put' do

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
