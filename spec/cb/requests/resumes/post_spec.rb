require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::Post do

    let(:request) { Cb::Requests::Resumes::Post.new(args) }
    let(:headers) do
      {
        'DeveloperKey' => Cb.configuration.dev_key,
        'HostSite' => Cb.configuration.host_site,
        'Content-Type' => 'application/json'
      }
    end

    context 'initialize without arguments' do
      let(:args) {{}}
      let(:body) do
        {
          desiredJobTitle: nil,
          privacySetting: nil,
          userIdentifier: nil,
          binaryData: nil
        }
      end

      it { expect(request.endpoint_uri).to eql Cb.configuration.uri_resume_post.sub(':resume_hash', '') }
      it { expect(request.http_method).to eql :post }
      it { expect(request.query).to eql nil  }
      it { expect(request.headers).to eql headers }
      it { expect(request.body).to eql body }
    end

    context 'initialize with arguments' do
      let(:args) do
        {
          resume_hash: 'hash',
          desired_job_title: 'desiredJobTitle',
          privacy_setting: 'privacySetting',
          user_identifier: 'userIdentifier',
          binary_data: 'binaryData'
        }
      end

      let(:body) do
        {
          desiredJobTitle: 'desiredJobTitle',
          privacySetting: 'privacySetting',
          userIdentifier: 'userIdentifier',
          binaryData: 'binaryData'
        }
      end

      it { expect(request.endpoint_uri).to eql Cb.configuration.uri_resume_post.sub(':resume_hash', 'hash') }
      it { expect(request.body).to eql body }
    end
  end
end
