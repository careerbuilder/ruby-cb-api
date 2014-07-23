require 'spec_helper'

module Cb
  describe Cb::Requests::WorkStatus::List do

    describe '#new' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::WorkStatus::List.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_work_status_list
          expect(@request.http_method).to eq :get
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq ({ HostSite: nil })
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq nil
        end

        it 'should have a basic body' do
          expect(@request.body).to eq nil
        end
      end

      context 'with arguments' do
        before :each do
          @request = Cb::Requests::WorkStatus::List.new({
            host_site: 'US'
          })
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_work_status_list
          expect(@request.http_method).to eq :get
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq ({ HostSite: "US" })
        end

        it 'should have basic headers' do
          expect(@request.headers).to eq nil
        end

        it 'should have a basic body' do
          expect(@request.body).to eq nil
        end
      end
    end
  end
end
