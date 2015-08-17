module Mocks
  class Observer
    def update(api_call)
      # puts "hello I am observer for #{api_call.api_call_type.to_s} #{api_call.path}"
    end
  end
end
