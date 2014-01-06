module Cb
  module Clients
    class Application
      class << self
        def get(criteria)
          Responses::Application::Get.new
        end
      end
    end
  end
end
