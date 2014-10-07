module Cb
  module Responses
    module User

      class Retrieve < ApiResponse

        attr_reader :status

        def initialize(args)
          super(args)
          @status = extract_status
        end

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(request_node, response[root_node])
        end

        def extract_models
          Models::User.new response[root_node][user_info_node]
        end

        def extract_status
          response[root_node][response_status]
        end

        def hash_containing_metadata
          response
        end

        private

        def root_node
          'ResponseUserInfo'
        end

        def request_node
          'Request'
        end

        def user_info_node
          'UserInfo'
        end

        def response_status
          'Status'
        end
      end

    end
  end
end
