require 'httparty'

module Cb::Utils
  class Api
    include HTTParty
    base_uri 'http://api.careerbuilder.com'

    def initialize
      self.class.debug_output $stderr if Cb.configuration.debug_api
      self.class.default_params :developerkey => Cb.configuration.dev_key,
                                :outputjson => Cb.configuration.use_json.to_s

      self.class.default_timeout Cb.configuration.time_out
    end

    def cb_get(*args, &block)
      self.class.base_uri 'http://api.careerbuilder.com'
      self.class.get(*args, &block)
    end

    def cb_post(*args, &block)
      self.class.base_uri 'https://api.careerbuilder.com'
      self.class.post(*args, &block)
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
          elsif self.class.is_numeric?(api_value)
            api_value = api_value.to_i
          end
          meta_class.class.send(:attr_reader, meta_name)
          meta_class.instance_variable_set(:"@#{meta_name}", api_value)
        end
      end

      obj.class.send(:attr_reader, 'cb_response')
      obj.instance_variable_set(:@cb_response, meta_class)
    end

    def self.criteria_to_hash(criteria)
      params = Hash.new
      if criteria.respond_to?(:instance_variables)
        criteria.instance_variables.each do |var|
          var_name = var.to_s
          var_name.slice!(0)
          var_name_hash_safe = camelize(var_name)
          params["#{var_name_hash_safe}"] = criteria.instance_variable_get(var)
        end
      end
      return params
    end

    def self.is_numeric?(obj)
      true if Float(obj) rescue false
    end

    private
    #############################################################################
    def self.camelize(input)
      input.sub!(/^[a-z\d]*/) { $&.capitalize }
      input.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$2.capitalize}" }.gsub('/', '::')
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