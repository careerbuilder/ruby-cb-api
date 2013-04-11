require 'HTTParty'

module Cb::Utils
  class Api
    include HTTParty
    base_uri 'http://api.careerbuilder.com'
    debug_output $stderr

    def initialize
      self.class.default_params :developerkey => Cb.configuration.dev_key,
                                :outputjson => Cb.configuration.use_json.to_s

      self.class.default_timeout Cb.configuration.time_out
    end

    def cb_get(*args, &block)
      self.class.get(*args, &block)
    end

    def append_api_responses(obj, resp)
      if obj.respond_to?('cb_response')
        meta_class = obj.cb_response
      else
        meta_class = Cb::Utils::MetaValues.new()
      end

      resp.each do | api_key, api_value |
        meta_name = get_meta_name_for api_key

        unless meta_name.empty?
          if meta_name == 'errors' && api_value.is_a?(Hash)
            api_value = api_value.values
          elsif is_numeric?(api_value)
            api_value = api_value.to_i
          end

          meta_class.class.send(:attr_reader, meta_name)
          meta_class.instance_variable_set(:"@#{meta_name}", api_value)
        end
      end

      obj.class.send(:attr_reader, 'cb_response')
      obj.instance_variable_set(:@cb_response, meta_class)
    end

    private
    #############################################################################

    def is_numeric?(obj)
      true if Float(obj) rescue false
    end

    def get_meta_name_for(api_key)
      key_map = {
                  'Errors' =>                     'errors',
                  'TimeResponseSent' =>           'time_sent',
                  'TimeElapsed' =>                'time_elapsed',
                  'TotalPages' =>                 'total_pages',
                  'TotalCount' =>                 'total_count',
                  'FirstItemIndex' =>             'first_item_index',
                  'LastItemIndex' =>              'last_item_index',
                  'CountryCode' =>                'country_code',
                  'DeveloperKey' =>               'developer_key',
                  'SiteID' =>                     'site_id',
                  'CoBrand' =>                    'co_brand',
                  'CountLimit' =>                 'count_limit',
                  'MinQualityLimit' =>            'min_quality',
                  'RecommendationsAvailable' =>   'recs_available'
      }

      key_map["#{api_key}"] ||= ''
    end
  end
end