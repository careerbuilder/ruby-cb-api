module Cb
  class CbCategory
  	attr_accessor :code, :name, :language
  	def initialize(args={})
  	  @code					= args["Code"] || ""
  	  @name					= args["Name"]["#text"] || ""
      @language     = args["Name"]["@language"] || ""
    end

    def CategoryName()
      return @name if @name.present?
    end

    def CategoryCode()
      return @code if @code.present?
    end

    def CategoryLanguage()
      return @language if @language.present?
    end
  end
end