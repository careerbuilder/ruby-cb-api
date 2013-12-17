module Cb
  module Responses
    module SavedSearch

      class Delete < ApiResponse
        protected

        def validate_api_hash
          raise "Response can't be nil!" if response.nil?
          required_response_field('Status', response)
        end

        def hash_containing_metadata
          response
        end

        def extract_models
          Models::SavedSearch::Delete.new(response)
        end

        def raise_on_timing_parse_error
          false
        end
      end

    end
  end
end
