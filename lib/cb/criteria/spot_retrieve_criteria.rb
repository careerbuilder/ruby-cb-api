module Cb
  class SpotRetrieveCriteria
    extend Cb::Utils::FluidAttributes

    fluid_attr_accessor :contenttype, :language, :sortfield, :sortdirection, :maxitems

    def retrieve
      Cb::SpotApi.retrieve self
    end
  end
end
