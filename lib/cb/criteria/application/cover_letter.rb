require 'nokogiri'

module Cb
  module Criteria
    module Application
      class CoverLetter
        extend Cb::Utils::FluidAttributes
        fluid_attr_accessor :cover_letter_id, :cover_letter_text, :cover_letter_title
      end
    end
  end
end
