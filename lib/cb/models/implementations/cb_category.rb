module Cb
  class CbCategory
  	attr_accessor :code, :name, :language
  	def initialize(args={})
  	  @code					= args["Code"]              || String.new
  	  @name					= args["Name"]["#text"]     || String.new
      @language     = args["Name"]["@language"] || String.new
    end

    def CategoryName()
      @name unless @name.nil?
    end

    def CategoryCode()
      @code unless @code.nil?
    end

    def CategoryLanguage()
      @language unless @language.nil?
    end
  end
end