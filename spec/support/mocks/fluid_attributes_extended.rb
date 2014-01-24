module Mocks
  class FluidAttributesExtended
    extend Cb::Utils::FluidAttributes

    fluid_attr_accessor :some_attr, :another_attr
  end
end
