module Cb
  module Clients
    class EmployeeTypes < ApiRequest

      def initialize
        @list_endpoint = Cb.configuration.uri_employee_types
        super
      end

      def search
        json = cb_client.cb_get(list_endpoint)
        new_response_object(json)
      end

      def search_by_hostsite(host_site)
        json = cb_client.cb_get(list_endpoint, :query => { :CountryCode => host_site })
        new_response_object(json)
      end

      private

      def new_response_object(json_response)
        Responses::EmployeeTypes::Search.new(json_response)
      end
    end

  end
end
