require 'spec_helper'

describe Cb::Utils::Api do
  context '#initialize' do
    it 'sets default gzip headers' do
      client = Cb::Utils::Api.new
      client.class.headers.should have_key('accept-encoding')
      client.class.headers['accept-encoding'].should == 'deflate, gzip'

    end
  end

end
