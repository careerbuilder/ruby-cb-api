module Cb
  class BaseClient
    attr_accessor :list_endpoint, :retrieve_endpoint, :create_endpoint, :update_endpoint, :delete_endpoint
    attr_reader   :cb_client

    def initialize
      init_base_client
      set_endpoints
    end

    private

    def init_base_client
      @cb_client = Cb.api_client.new
    end

    def set_endpoints
      raise NotImplementedError.new
    end
  end
end
