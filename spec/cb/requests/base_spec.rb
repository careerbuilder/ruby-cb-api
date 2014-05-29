require 'spec_helper'

module Cb
  describe Cb::Requests::Base do

    context 'initialize' do
      it 'should have unimplemented errors' do
        base = Cb::Requests::Base.new({})
        expect { base.endpoint_uri }.to raise_error(NotImplementedError)
        expect { base.http_method }.to raise_error(NotImplementedError)
      end
      it 'should have error when not given a hash' do
        expect { Cb::Requests::Base.new('') }.to raise_error(ArgumentError)
      end
    end

  end
end
