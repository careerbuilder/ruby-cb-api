require 'HTTParty'

module Cb::Utils
  class Api
    include HTTParty
    base_uri 'http://api.careerbuilder.com'
    #debug_output $stderr

    def initialize
      self.class.default_params :developerkey => Cb.configuration.dev_key,
                                :outputjson => Cb.configuration.use_json.to_s

      self.class.default_timeout Cb.configuration.time_out
    end

    def cb_get(*args, &block)
      response = self.class.get(*args, &block)

      return response
    end

    private
    #############################################################################

    def populate_from(response, node = '')
      @errors 		= response[node]['Errors'] || ''
      @time_elapsed	= response[node]['TimeResponseSent'] || ''
      @time_sent		= response[node]['TimeElapsed'] || ''
    end
  end
end