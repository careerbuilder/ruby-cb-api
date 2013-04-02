module Cb
  class CbEducation
    attr_accessor :code, :text, :language

    ##############################################################
    ## This object stores Education Codes having to do with a
    ## country. The API objects dealing with job, will populate
    ## one or many of this object.
    ##
    ## For more information, please visit:
    ## http://api.careerbuilder.com/v1/educationcodes
    ##############################################################
    def initialize(args = {})
      return if args.nil?

      @code          = args['Code'] || ''
      @language			 = args['Name']['@language'] unless args['Name'].nil?
      @text          = args['Name']['#text'] unless args['Name'].nil?

      # I have got to find a better way to do this
      @language ||= ''
      @text ||= ''
    end
  end
end