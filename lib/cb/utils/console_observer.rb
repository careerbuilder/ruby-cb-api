module Cb
  module Utils
    class ConsoleObserver
      def update(api_call)
        puts "#{api_call.api_call_type.to_s} #{api_call.path}/#{api_call.options.to_s} response: #{api_call.response.to_json}"
      end
    end
  end
end

