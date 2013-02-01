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
      @cb_api_dev_key   = "WDhd88S735S3V2NWZKPD" # "ruby-cb-api"  # Get a developer key at http://api.careerbuilder.com/RequestDevKey.aspx
      @api_time_out     = 5
      @use_json         = true
    end
  end
end