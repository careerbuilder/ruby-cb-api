require 'spec_helper'

module Cb
  describe Cb::Config do
    context '.to_hash' do
      it 'should return a hash' do
      	config = Cb.configuration

      	config.is_a?(Cb::Config).should == true
      	config.to_hash.is_a?(Hash).should == true
      end
    end
    context 'defaults' do
      it 'should have a base_uri' do
        config = Cb.configuration
        config.base_uri.should_not be_nil
      end
    end
    context 'uri' do
      it 'should change base_uri' do
        uri = 'hello world'
        config = Cb.configuration
        default_uri = config.base_uri

        config.set_base_uri(uri)
        config.base_uri.should == uri

        config.set_base_uri(default_uri)
        config.base_uri.should == default_uri
      end
    end
  end
end