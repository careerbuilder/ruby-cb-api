require 'spec_helper'

module Cb
  describe Clients::EmployeeTypes do
    let(:client_under_test) { Clients::EmployeeTypes.new }
    let(:cb_api_client)     { (Cb.api_client.new) }

    before(:each) do
      allow(cb_api_client).to receive(:cb_get).and_return({ 'bananas' => '4life' })
      allow(Cb.api_client).to receive(:new).and_return(cb_api_client)
      response = double(Responses::EmployeeTypes::Search)
      allow(response).to receive(:class).and_return Responses::EmployeeTypes::Search
      allow(Responses::EmployeeTypes::Search).to receive(:new).and_return(response)
    end

    context '#new' do
      it 'returns a type of Cb::Clients::EmployeeTypes' do
        expect(Clients::EmployeeTypes.new.class).to eq Cb::Clients::EmployeeTypes
      end
    end

    def returns_response_object(method, *args)
      response = client_under_test.send(method, *args)
      expect(response.class).to eq Responses::EmployeeTypes::Search
    end

    context '#search' do
      it 'calls the employee types endpoint' do
        endpoint_url = Cb.configuration.uri_employee_types
        expect(cb_api_client).to receive(:cb_get).with(endpoint_url)
        client_under_test.search
      end

      it 'returns a response object' do
        returns_response_object(:search)
      end
    end

    context '#search_by_hostsite' do
      it 'calls the employee types endpoint with hostsite query string' do
        endpoint_url = Cb.configuration.uri_employee_types
        hostsite = 'de'
        query = { :query => { :CountryCode => hostsite } }
        expect(cb_api_client).to receive(:cb_get).with(endpoint_url, query)
        client_under_test.search_by_hostsite(hostsite)
      end

      it 'returns a response object' do
        returns_response_object(:search_by_hostsite, 'us')
      end
    end

  end
end
