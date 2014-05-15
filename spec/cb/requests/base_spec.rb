require 'spec_helper'

module Cb
  describe Cb::Requests::Base do

    context 'initialize' do
      it 'should raise error' do
        expect{ Cb::Requests::Base.new({}) }.to raise_error()
      end
    end

  end
end
