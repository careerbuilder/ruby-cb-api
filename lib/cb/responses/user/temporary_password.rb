module Cb
  module Responses
    module User

      class TemporaryPassword < ApiResponse

        # there's really no response model here, so let's just
        # pass the string along in a way that makes sense.
        alias_method :temp_password, :models

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(password_node, response[root_node])
        end

        def extract_models
          response[root_node][password_node]
        end

        def hash_containing_metadata
          response[root_node]
        end

        def raise_on_timing_parse_error
          false
        end

        private

        def root_node
          'ResponseTemporaryPassword'
        end

        def password_node
          'TemporaryPassword'
        end
      end

    end
  end
end
