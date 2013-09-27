module Cb
  module Responses
    class RawApiResponse
      attr_accessor :raw_api_hash

      def initialize(raw_api_response={})
        @raw_api_hash = raw_api_response
        validate_raw_api_response
      end

      def extract_models
        # your api hash is considered valid at this point - grab the data you need and turn it into model(s)
        raise NotImplementedError
      end

      def validate_raw_api_response
        # call #required_response_field in here for each node that you know you'll need - stuff like the root node
        # or the node that contains the data from which your model is built.
        raise NotImplementedError
      end

      # aliased just in case the data you're working with is singular in nature (i.e. a single job/resume)
      alias_method :extract_model, :extract_models

      protected

      def required_response_field(field_name, parent_hash)
        %w(field_name parent_hash).each { |param| raise "#{param} can't be nil, that makes no sense!" if param.nil? }
        raise ExpectedResponseFieldMissing.new(field_name) unless parent_hash.has_key? field_name
      end

    end
  end
end
