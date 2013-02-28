module Cb
	class CbEducationCode
		attr_accessor :education_code, :education_name


    ##############################################################
		## This object stores Education Codes having to do with a 
    ## country. The API objects dealing with job, will populate
    ## one or many of this object.
		##############################################################
		def initialize(args = {})

			@education_code                         = args["Code"] || ""
      @education_name                         = args["Name"]["#text"] || ""

    end

    # @country_code = ["UK","US","IN"]
 #    ['AH','BE','CA','CC','CE','CH','CN','CP','CS','CY','DE','DK','E1','ER','ES','EU','F1'
	# ,'FR','GC','GR','I1','IE','IN','IT','J1','JC','JS','LJ','M1','MY','NL','NO','PD','PI','PL','RM','RO','RX'
	# ,'S1','SE','SF','SG','T1','T2','UK','US','WH','WM','WR']

  end
end