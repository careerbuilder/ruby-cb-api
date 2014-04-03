module Cb
  module Models
    class Industry < ApiResponseModel

      attr_accessor :code, :name, :language

      def initialize(args={})
        super(args)
      end


      protected
      def required_fields
        []
      end

      def set_model_properties
        args = api_response

        @code					= args["Code"]              || String.new
        @name					= args["Name"]["#text"]     || String.new
        @language     = args["Name"]["@language"] || String.new
      end

    end
  end
end
