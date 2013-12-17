module Cb
  module Criteria
    module Spot
      class Retrieve
        extend Cb::Utils::FluidAttributes

        fluid_attr_accessor :contenttype, :language, :sortfield, :sortdirection, :maxitems
        (1..8).each { |num| fluid_attr_accessor "field#{num.to_s}".to_sym }
      end
    end
  end
end
