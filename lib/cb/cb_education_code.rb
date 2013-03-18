module Cb
	class CbEducationCode
		extend FluidAttributes
		fluid_attr_accessor :education_code, :education_name, :education_language


    ##############################################################
		## This object stores Education Codes having to do with a 
    ## country. The API objects dealing with job, will populate
    ## one or many of this object.
		##############################################################
		def initialize(args = {})

			@education_code                         = args["Code"] || ""
			@education_language											=	args["Name"]["@language"] || ""
      @education_name                         = args["Name"]["#text"] || ""

    end


  end
end