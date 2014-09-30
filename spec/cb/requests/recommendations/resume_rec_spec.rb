require 'spec_helper'

module Cb
  describe Cb::Requests::Recommendations::Resume do
    describe '#new' do
      context 'without arguments' do
        let(:request) { Cb::Requests::Recommendations::Resume.new({}) }

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_recommendation_for_resume.sub(':resume_hash', '') }

        it { expect(request.http_method).to eq :get }

        it { expect(request.query).to eq({ externalID: nil }) }

        it { expect(request.body).to eq nil }

        it { expect(request.headers).to eq ({
                                              'DeveloperKey' => Cb.configuration.dev_key,
                                              'HostSite' => Cb.configuration.host_site,
                                              'Content-Type' => 'application/json'
                                            }) }
      end

      context 'with arguments' do
        let (:request) do
          Cb::Requests::Recommendations::Resume.new({ resume_hash: 'resumeHash', external_user_id: 'externalUserId' })
        end

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_recommendation_for_resume.sub(':resume_hash', 'resumeHash') }

        it { expect(request.http_method).to eq :get }

        it { expect(request.query).to eq ({ externalID: 'externalUserId' }) }

        it { expect(request.body).to eq nil }

        it { expect(request.headers).to eq ({
                                              'DeveloperKey' => Cb.configuration.dev_key,
                                              'HostSite' => Cb.configuration.host_site,
                                              'Content-Type' => 'application/json'
                                            }) }
      end
    end
  end
end
