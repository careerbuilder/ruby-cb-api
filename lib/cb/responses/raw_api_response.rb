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

      def root_node
        raise NotImplementedError.new(__method__)
      end

      def root_hash
        raw_api_hash[root_node]
      end

      def required_response_field(field_name, parent_hash)
        [field_name, parent_hash].each do |arg|
          raise ArgumentError.new("No nils! field_name nil?: #{field_name.nil?} parent_hash nil?: #{parent_hash.nil?}") if arg.nil?
        end
        raise ExpectedResponseFieldMissing.new(field_name) unless parent_hash.has_key? field_name
      end

      def append_api_responses(resp)
        meta_class = self.respond_to?('cb_response') ? self.cb_response : Cb::Utils::MetaValues.new

        resp.each do |api_key, api_value|
          meta_name = format_hash_key(api_key)
          unless meta_name.empty?
            if meta_name == 'errors' && api_value.is_a?(Hash)
              api_value = api_value.values
            elsif meta_name == 'error' && api_value.is_a?(String)
              meta_name = 'errors'
              api_value = [api_value]
            elsif self.class.is_numeric?(api_value)
              api_value = api_value.to_i
            end

            meta_class.class.send(:attr_reader, meta_name)
            meta_class.instance_variable_set(:"@#{meta_name}", api_value)
          end
        end

        self.class.send(:attr_reader, 'api_error')
        self.instance_variable_set(:@api_error, @api_error)

        self.class.send(:attr_reader, 'cb_response')
        self.instance_variable_set(:@cb_response, meta_class)
        self
      end

      private

      def format_hash_key(api_hash_key)
        return String.new unless api_hash_key.respond_to?(:snakecase)
        api_hash_key.snakecase
      end

    end
  end
end
