module Mocks
  class Observer
    def update(api_call_type, path, options, response)
      puts "hello I am observer for #{api_call_type.to_s} #{path}"
    end
  end
end
