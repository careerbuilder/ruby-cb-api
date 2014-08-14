module Mocks
  class OAuthToken
    attr_reader :what_to_return
    def initialize(what_to_return)
      @what_to_return = what_to_return
    end
    def get(path, opts = {})
      @what_to_return
    end
  end
end
