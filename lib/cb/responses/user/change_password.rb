module Cb
  module Responses
    module User

      class ChangePassword < ApiResponse
        class Model < Struct.new(:success) ; end

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(request_node, response[root_node])
        end

        def extract_models
          model = Model.new()
          model.success = response[root_node][success_node]
        end

        def metadata_containing_node
          response[root_node]
        end

        def hash_containing_metadata
          response
        end

        private

        def root_node
          'ResponseUserChangePW'
        end

        def request_node
          'Request'
        end

        def success_node
          'Success'
        end
      end

    end
  end
end
