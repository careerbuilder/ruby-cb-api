module Mocks
  class CallbackTest
    attr_reader :callback_value
    def initialize
      @callback_value = false
    end
    def callback_method(arg)
      @callback_value = arg
    end
  end
end
