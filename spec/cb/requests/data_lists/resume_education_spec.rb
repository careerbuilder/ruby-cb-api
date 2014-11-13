require 'spec_helper'

module Cb
  module Requests
    describe DataLists::ResumeEducation do
      subject { DataLists::ResumeEducation.new({}) }

      let(:headers) do
        {
            'DeveloperKey' => Cb.configuration.dev_key,
            'Content-Type' => 'application/json'
        }
      end

      it { expect(subject.endpoint_uri).to eql Cb.configuration.uri_resume_education }
      it { expect(subject.headers).to eql headers }
      it { expect(subject.http_method).to eql :get }
      it { expect(subject.body).to eql nil }

    end
  end
end
