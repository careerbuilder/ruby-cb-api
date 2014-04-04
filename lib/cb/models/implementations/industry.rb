module Cb
  module Models
    class Industry < ApiResponseModel

      attr_accessor :code, :name

      def initialize(args={})
        @api_response = args
        @code         = args["Code"]              || String.new
        @name         = args["Name"]["#text"]     || String.new
        @language     = args["Name"]["@language"] || String.new

        validate_api_response
      end

      protected

      def required_fields
        %w(Code Name)
      end

    end
  end
end
