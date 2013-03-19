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
      self.class.get(*args, &block)
    end

    def append_api_responses(obj, resp)
      meta_class = Cb::Utils::MetaValues.new()
     
      resp.each do | api_key, api_value |
        meta_name = get_meta_name_for api_key
    
        unless meta_name.empty?
          meta_class.class.send(:attr_reader, meta_name)
          meta_class.instance_variable_set(:"@#{meta_name}", api_value)
        end
      end
      
      obj.class.send(:attr_reader, 'cb_response')
      obj.instance_variable_set(:@cb_response, meta_class)
    end

    private
    #############################################################################
    def get_meta_name_for(api_key)
      map = {
              'Errors' =>              'errors',
              'TimeResponseSent' =>    'time_sent',
              'TimeElapsed' =>         'time_elapsed',
              'TotalPages' =>          'total_pages',
              'TotalCount' =>          'total_count',
              'FirstItemIndex' =>      'first_item_index',
              'LastItemIndex' =>       'last_item_index',
              'CountryCode' =>         'country_code'
      }

      map["#{api_key}"] ||= ''
    end
  end
end