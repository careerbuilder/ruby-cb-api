module Cb
  module Clients

    class ApiRequest
    	
      attr_accessor :cb_client, :list_endpoint, :show_endpoint, :create_endpoint, :update_endpoint, :delete_endpoint

      def initialize
        @cb_client = Cb.api_client.new
      end
    end
  end
end
