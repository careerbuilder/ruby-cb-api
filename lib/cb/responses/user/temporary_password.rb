module Cb
  module Responses
    module User

      class TemporaryPassword < ApiResponse

        # there's really no response model here, so let's just
        # pass the new password along in a way that makes sense.
        alias_method :temp_password, :model

        protected

        def validate_api_hash
          required_response_field(password_node, response)
        end

        def extract_models
          response[password_node]
        end

        def hash_containing_metadata
          response
        end

        def raise_on_timing_parse_error
          false
        end

        private

        def password_node
          'TemporaryPassword'
        end
      end

    end
  end
end
