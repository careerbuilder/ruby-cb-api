module Cb
  module Clients
    class ApplicationV2
      class << self
        def get(criteria)
          Responses::Application::Get.new
        end
      end
    end
  end
end
