require 'spec_helper'

module Cb
  describe Requests::Job::Report do
    let(:request) { described_class.new({}) }
    let(:endpoint) { '/v1/job/report' }

    it { expect(request.http_method).to eql(:post) }
    it { expect(request.endpoint_uri).to eql(endpoint) }
  end
end
