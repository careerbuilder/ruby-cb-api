require 'spec_helper'

module Cb
  describe Cb::Clients::EmailSubscription do

    def expect_email_sub_model(model)
      expect(model).to be_an_instance_of(Models::EmailSubscription)
    end

    context '#retrieve_by_did' do

      def stub_api_to_return(content)
        stub_request(:get, uri_stem(Cb.configuration.uri_subscription_retrieve)).
          to_return(:body => content.to_json)
      end

      context 'when everything is working smoothly' do
        let(:mock_api) { double(Cb::Utils::Api) }

        before :each do
          mock_api.stub(:cb_get).and_return(Hash.new)
          mock_api.stub(:append_api_responses)
          Cb::Utils::Api.stub(:new).and_return(mock_api)
        end

        it 'pings the subscription retrieve endpoint with HTTPS' do
          https_method_name = :cb_get

          mock_api.should_receive(https_method_name).
            with(Cb.configuration.uri_subscription_retrieve, kind_of(Hash)).
            and_return(Hash.new)

          Cb::Clients::EmailSubscription.retrieve_by_did('fake-did')
        end

        it 'includes the external ID and hostsite in the URL' do
          xid = 'fake-did'
          host_site = 'site'

          mock_api.should_receive(:cb_get).
            with(kind_of(String), { :query => { :ExternalID => xid, :Hostsite => host_site } }).
            and_return(Hash.new)

          Cb::Clients::EmailSubscription.retrieve_by_did(xid, host_site)
        end

        it 'appends the generic API responses to the returned object' do
          mock_api.should_receive(:append_api_responses)
          Cb::Clients::EmailSubscription.retrieve_by_did('fake-did')
        end
      end

      context 'when required API response fields are present' do
        before(:each) { stub_api_to_return({ 'SubscriptionValues' => { :stuff => 'here' } }) }

        it 'returns an email subscription model' do
          expect_email_sub_model Cb::Clients::EmailSubscription.retrieve_by_did('fake-did')
        end
      end

      context 'when required API response fields are not present' do
        before(:each) { stub_api_to_return({ 'SubscriptionValues' => nil }) }

        it 'returns nil' do
          model = Cb::Clients::EmailSubscription.retrieve_by_did('fake-did')
          expect(model).to be_nil
        end

        it 'appends api responses to the nil returned value' do
          mock_api = double(Cb::Utils::Api)
          mock_api.stub(:cb_get).and_return(Hash.new)
          mock_api.should_receive(:append_api_responses)
          Cb::Utils::Api.stub(:new).and_return(mock_api)
          Cb::Clients::EmailSubscription.retrieve_by_did('fake-did')
        end
      end

    end # retrieve_by_did

    context '#modify_subscription' do
      def stub_api_to_return(content)
        stub_request(:post, uri_stem(Cb.configuration.uri_subscription_modify)).
          to_return(:body => content.to_json)
      end

      context 'when posting over the wire' do
        let(:mock_api) { double(Cb::Utils::Api) }

        before :each do
          mock_api.stub(:append_api_responses)
          mock_api.stub(:cb_post)
          Cb::Utils::Api.stub(:new).and_return(mock_api)
        end
      end

    end # modify_subscription

  end
end
