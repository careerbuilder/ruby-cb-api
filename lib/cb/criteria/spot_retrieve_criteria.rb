module Cb::Criteria
  class SpotRetrieve
    extend Cb::Utils::FluidAttributes

    fluid_attr_accessor :contenttype, :language, :sortfield, :sortdirection, :maxitems
    (1..8).each { |num| fluid_attr_accessor "field#{num.to_s}".to_sym }

    def retrieve
      Cb::Clients::Spot.retrieve self
    end
  end
end
