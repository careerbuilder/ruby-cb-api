require 'spec_helper'

module Cb
  describe Cb::Requests::State::Get do
    describe '#new' do

      context 'without arguments' do
        let(:request) { Cb::Requests::State::Get.new({}) }
        let(:query){
          {
              countryCode: nil,
              outputjson: true
          }
        }

        it { expect(request.endpoint_uri).to eq Cb.configuration.uri_state_list }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq(query) }
        it { expect(request.body).to eq nil }
        it { expect(request.base_uri).to eq 'https://www.careerbuilder.com'}
      end

      context 'with arguments' do
        let (:request) do
          Cb::Requests::State::Get.new({ country_code: 'GR' })
        end
        let(:query){
          {
              countryCode: 'GR',
              outputjson: true
          }
        }

        it { expect(request.endpoint_uri).to eq(Cb.configuration.uri_state_list) }
        it { expect(request.http_method).to eq :get }
        it { expect(request.query).to eq (query) }
        it { expect(request.body).to eq nil }
      end
    end
  end
end
