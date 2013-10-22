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
  end
end