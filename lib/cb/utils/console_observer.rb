module Cb
  module Utils
    class ConsoleObserver
      def update(api_call_type, path, options, response)
        puts "#{api_call_type.to_s} #{path}/#{options.to_s} response: #{response.to_json}"
      end
    end
  end
end

