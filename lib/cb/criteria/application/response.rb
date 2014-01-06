require 'nokogiri'

module Cb
  module Criteria
    class Application
      class Response
        extend Cb::Utils::FluidAttributes
        fluid_attr_accessor :question_id, :response_text
      end
    end
  end
end
