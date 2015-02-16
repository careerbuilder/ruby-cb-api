require 'spec_helper'

describe Cb::Utils::Api do
  context '#initialize' do
    it 'sets default gzip headers' do
      client = Cb::Utils::Api.new
      expect(client.class.headers).to have_key('accept-encoding')
      expect(client.class.headers['accept-encoding']).to eq('deflate, gzip')

    end
  end

end
