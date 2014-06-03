require 'spec_helper'

module Cb
  describe Cb::Requests::EmailSubscription::Retrieve do

    describe '#new' do
      context 'without arguments' do
        before(:each) { @request = Cb::Requests::EmailSubscription::Retrieve.new({}) }

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_subscription_retrieve
          expect(@request.http_method).to eq :get
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(
            {
              :ExternalID => nil,
              :HostSite => nil
            }
          )
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
          @request = Cb::Requests::EmailSubscription::Retrieve.new({
            host_site: 'host site',
            external_id: 'external id'
          })
        end

        it 'should be correctly configured' do
          expect(@request.endpoint_uri).to eq Cb.configuration.uri_subscription_retrieve
          expect(@request.http_method).to eq :get
        end

        it 'should have a basic query string' do
          expect(@request.query).to eq(
            {
              :ExternalID => "external id",
              :HostSite => "host site"
            }
          )
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
