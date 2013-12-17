module Cb
  module Clients

    class EmployeeTypes
      def search
        json = cb_client.cb_get(endpoint)
        new_response_object(json)
      end

      def search_by_hostsite(host_site)
        json = cb_client.cb_get(endpoint, :query => { :CountryCode => host_site })
        new_response_object(json)
      end

      private

      def cb_client
        @client ||= Cb.api_client.new
      end

      def endpoint
        Cb.configuration.uri_employee_types
      end

      def new_response_object(json_response)
        Responses::EmployeeTypes::Search.new(json_response)
      end
    end

  end
end
