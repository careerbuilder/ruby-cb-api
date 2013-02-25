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
  end
end