require 'json'

module Cb
  module ResponseValidator

    def self.validate(response)
      if response.blank? || response.response.body.blank?
        return self.get_empty_json_hash
      end

      if response.code != 200
        return self.get_empty_json_hash
      end

      begin
        json = JSON.parse(response.response.body)
        if json.keys.any?
          return json
        else
          return self.get_empty_json_hash
        end
      rescue JSON::ParserError
        return self.get_empty_json_hash
      end
    end

    def self.get_empty_json_hash
      return JSON.parse('{}')
    end

  end
end