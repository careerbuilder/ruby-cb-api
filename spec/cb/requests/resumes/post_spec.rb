require 'spec_helper'

module Cb
  describe Cb::Requests::Resumes::Post do

    let(:request) { Cb::Requests::Resumes::Post.new(args) }
    let(:headers) do
      {
        'HostSite' => Cb.configuration.host_site,
        'Content-Type' => 'application/json',
        'Authorization' => 'Bearer '
      }
    end

    context 'initialize without arguments' do
      let(:args) {{}}
      let(:body) do
        {
          desiredJobTitle: nil,
          privacySetting: nil,
          resumeFileData: nil,
          resumeFileName: nil,
          hostSite: nil,
        }.to_json
      end

      it { expect(request.endpoint_uri).to eq Cb.configuration.uri_resume_post }
      it { expect(request.http_method).to eq :post }
      it { expect(request.query).to eq nil  }
      it { expect(request.headers).to eq headers }
      it { expect(request.body).to eq body }
    end

    context 'initialize with arguments' do
      let(:args) do
        {
          desired_job_title: 'desiredJobTitle',
          privacy_setting: 'privacySetting',
          resume_file_data: 'binaryData',
          resume_file_name: 'fileName',
          host_site: 'US',
          three_scale_token: 'token'
        }
      end

      let(:headers) do
        {
            'HostSite' => Cb.configuration.host_site,
            'Content-Type' => 'application/json',
            'Authorization' => 'Bearer token'
        }
      end

      let(:body) do
        {
          desiredJobTitle: 'desiredJobTitle',
          privacySetting: 'privacySetting',
          resumeFileData: 'binaryData',
          resumeFileName: 'fileName',
          hostSite: 'US'
        }.to_json
      end

      it { expect(request.endpoint_uri).to eq Cb.configuration.uri_resume_post }
      it { expect(request.body).to eq body }
    end
  end
end
