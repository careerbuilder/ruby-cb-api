require 'spec_helper'

module Cb
  describe Cb::Utils::Api do
    context '.new' do
      it 'should create an empty new api object' do
        api = Cb::Utils::Api.new()
        
        api.is_a?(Cb::Utils::Api).should == true
      end
    end
  end
end