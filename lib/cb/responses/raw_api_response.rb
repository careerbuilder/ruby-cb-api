module Cb
  module Responses
    class RawApiResponse

      attr_accessor :raw_api_hash

      def initialize(raw_api_response={})
        @raw_api_hash = raw_api_response
        validate_raw_api_response
      end

      def validate_raw_api_response
        # call #required_response_field in here for each node that you know you'll need - stuff like the root node
        # or the node that contains the data from which your model is built.
        raise NotImplementedError.new(__method__)
      end

      def extract_models
        # your api hash is considered valid at this point - grab the data you need and turn it into model(s)
        raise NotImplementedError.new(__method__)
      end

      protected

      def required_response_field(field_name, parent_hash)
        [field_name, parent_hash].each do |param|
          error_message = "Nothing can be nil here! field_name: #{field_name.to_s} parent_hash: #{parent_hash.to_s}"
          raise ArgumentError.new(error_message) if param.nil?
        end
        raise ExpectedResponseFieldMissing.new(field_name) unless parent_hash.has_key? field_name
      end

    end
  end
end
