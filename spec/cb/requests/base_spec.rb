require 'spec_helper'

module Cb
  describe Cb::Requests::Base do

    context 'initialize' do
      it 'should have unimplemented errors' do
        base = Cb::Requests::Base.new({})
        expect { base.endpoint_uri }.to raise_error(NotImplementedError)
        expect { base.http_method }.to raise_error(NotImplementedError)
      end
    end

  end
end
