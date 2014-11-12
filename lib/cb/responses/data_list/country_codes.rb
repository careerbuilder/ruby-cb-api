module Cb
  module Responses
    class CountryCodes < ApiResponse

      protected

      def validate_api_hash
        required_response_field(root_node, response)
        required_response_field(collection_node, response[root_node])
        required_response_field('CountryCode', response[root_node][collection_node])
      end

      def hash_containing_metadata
        response[root_node]
      end

      def extract_models
        model_hash.map! { |country_code| Models::CountryCode.new('CountryCode' => country_code) }
      end

      private

      def root_node
        'ResponseCountryCodes'
      end

      def collection_node
        'SupportedCountryCodes'
      end

      def model_hash
        response[root_node][collection_node]['CountryCode']
      end
    end
  end
end

