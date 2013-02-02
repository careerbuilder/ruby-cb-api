module Cb
  class Config
    attr_accessor :dev_key, :time_out, :use_json

    def initialize
      set_defaults
    end

    def to_hash
      {
        :dev_key      => @dev_key,
        :time_out  	  => @time_out,
        :use_json     => @use_json
      }
    end

    #################################################################
    ## private methods
    #################################################################
    private

    def set_defaults
      @dev_key      = "WDHH6P96RQD9FSDCZ0G7" # "ruby-cb-api"  # Get a developer key at http://api.careerbuilder.com/RequestDevKey.aspx
      @time_out     = 5
      @use_json     = true
    end
  end
end