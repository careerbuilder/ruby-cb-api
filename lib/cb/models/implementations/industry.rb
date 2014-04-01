module Cb
  module Models
    class Industry
      attr_accessor :code, :name, :language
      def initialize(args={})
        @code					= args["Code"]              || String.new
        @name					= args["Name"]["#text"]     || String.new
        @language     = args["Name"]["@language"] || String.new
      end

      def IndustryName()
        @name unless @name.nil?
      end

      def IndustryCode()
        @code unless @code.nil?
      end

      def IndustryLanguage()
        @language unless @language.nil?
      end
    end
  end
end
