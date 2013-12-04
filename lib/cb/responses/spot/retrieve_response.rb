require 'forwardable'

module Cb
  module Responses






    class ApiResponse
      extend Forwardable
      delegate [:timing, :errors] => :metadata
      delegate :[] => :response

      attr_reader :models, :response

      def initialize(raw_response_hash)
        set_response_variable(raw_response_hash)
        @metadata = extract_metadata
        @models   = validated_models
      end

      protected
      attr_reader :metadata

      def root_node
        raise NotImplementedError
      end

      def extract_models
        raise NotImplementedError
      end

      def validate_api_hash
        raise NotImplementedError
      end

      def metadata_containing_node
        raise NotImplementedError
      end

      def required_response_field(field_name, parent_hash)
        raise ArgumentError.new("field_name can't be nil!")  if field_name.nil?
        raise ArgumentError.new("parent_hash can't be nil!") if parent_hash.nil?
        raise ExpectedResponseFieldMissing.new(field_name) unless parent_hash.has_key?(field_name)
      end

      private

      def set_response_variable(response_hash)
        raise ApiError.new('Response is empty!') if response_hash.empty?
        @response = response_hash
      end

      def extract_metadata
        Metadata.new(metadata_containing_node)
      end

      def validated_models
        validate_api_hash
        extract_models
      end
    end




    class ApiError < Exception; end



    class Metadata
      attr_reader :errors, :timing

      def initialize(raw_response_hash)
        @response = raw_response_hash
        @errors   = parsed_errors
        @timing   = parsed_timing_info
      end

      private
      attr_reader :response

      def parsed_errors
        return Array.new unless response.respond_to?(:map)
        errors = response.map { |key, value| parsed_error(key, value) }.flatten
        raise ApiError.new(errors.to_s) unless errors.empty?
        errors
      end

      def parsed_error(key, value)
        if hashy_errors?(key, value)
          value.values
        elsif error_array?(key, value)
          value
        else
          Array.new
        end
      end
      
      def hashy_errors?(key, value)
        key.downcase == 'errors' && value.is_a?(Hash)
      end
      
      def error_array?(key, value)
        key.downcase == 'error' && value.is_a?(Array)
      end

      def parsed_timing_info
        Timing.new(response)
      end
    end







    class Timing
      attr_reader :response_sent, :elapsed
      
      def initialize(response)
        @response      = response
        post_initialize
      end

      private
      attr_reader :response

      def post_initialize
        raise ExpectedResponseFieldMissing.new('No timing info!') if response.nil?
        @response_sent = parsed_response_sent
        @elapsed       = response['TimeElapsed'] || String.new
      end

      def parsed_response_sent
        DateTime.parse(response['TimeResponseSent']) rescue DateTime.new
      end
    end








    module Spot
      class Retrieve < ApiResponse

        protected

        def validate_api_hash
          required_response_field(root_node, response)
          required_response_field(spot_collection, response[root_node])
        end

        def extract_models
          spot_hashes.map { |spot_data| Cb::Models::Spot.new(spot_data) }
        end

        def metadata_containing_node
          response[root_node]
        end

        private

        def root_node
          @root_node ||= 'ResponseRetrieve'
        end

        def spot_collection
          @spot_collection ||= 'SpotData'
        end

        def spot_hashes
          response[root_node][spot_collection]
        end
      end
    end

  end
end
