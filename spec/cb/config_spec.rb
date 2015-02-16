require 'spec_helper'

module Cb
  describe Cb::Config do
    context '.to_hash' do
      it 'should return a hash' do
      	config = Cb.configuration

      	expect(config.is_a?(Cb::Config)).to eq(true)
      	expect(config.to_hash.is_a?(Hash)).to eq(true)
      end
    end
    context 'defaults' do
      it 'should have a base_uri' do
        config = Cb.configuration
        expect(config.base_uri).not_to be_nil
      end
      it 'should have a base_uri with https' do
        config = Cb.configuration
        expect(config.base_uri[0..4]).to eq('https')
      end
    end
    context 'uri' do
      it 'should change base_uri' do
        uri = 'hello world'
        config = Cb.configuration
        default_uri = config.base_uri

        config.set_base_uri(uri)
        expect(config.base_uri).to eq(uri)

        config.set_base_uri(default_uri)
        expect(config.base_uri).to eq(default_uri)
      end
    end
  end
end