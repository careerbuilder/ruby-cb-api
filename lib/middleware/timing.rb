require 'observer'

module Middleware
  class Timing < Faraday::Middleware
    include ::Observable

    def initialize(app = nil, options = {})
      super(app)
      options.fetch(:observers, []).map(&:new).each do |observer|
        add_observer(observer)
      end
    end

    def call(request_env)
      api_caller = find_api_caller(caller)
      start_time = Time.now.to_f
      cb_event(:"cb_#{ request_env.method }_before", request_env.url.path, request_env.params, api_caller, nil, 0.0)
      @app.call(request_env).on_complete do |response_env|
        cb_event(:"cb_#{ response_env.method }_after", response_env.url.path, response_env.params, api_caller, response_env.body.to_s, Time.now.to_f - start_time)
      end
    end

    private

    def find_api_caller(call_list)
      filename_regex = /.*\.rb/
      linenum_regex = /:.*:in `/
      filename, method_name = call_list.find { |l| use_this_api_caller?(l[filename_regex]) }[0..-2].split(linenum_regex)
      simplified_filename = filename.include?('/lib/') ? filename[/\/lib\/.*/] : filename
      simplified_filename = simplified_filename.include?('/app/') ? simplified_filename[/\/app\/.*/] : simplified_filename
      { file: simplified_filename, method: method_name }
    end

    def use_this_api_caller?(calling_file)
      (calling_file == __FILE__ || calling_file.include?('/lib/cb/client.rb')) ? false : true
    end

    def api_call_model(api_call_type, path, options, api_caller, response, time_elapsed)
      Cb::Models::ApiCall.new(api_call_type, path, options, api_caller, response, time_elapsed)
    end

    def cb_event(api_call_type, path, options, api_caller, response, time_elapsed)
      call_model = api_call_model(api_call_type, path, options, api_caller, response, time_elapsed)
      changed(true)
      notify_observers(call_model)
    end

    def ensure_non_nil_metavalues(obj)
      if obj.respond_to?('cb_response') && !obj.cb_response.nil?
        obj.cb_response
      else
        Cb::Utils::MetaValues.new
      end
    end

    def self.camelize(input)
      input.sub!(/^[a-z\d]*/) { $&.capitalize }
      input.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{Regexp.last_match(2).capitalize}" }.gsub('/', '::')
    end
  end
end
