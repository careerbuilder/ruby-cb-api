module Cb
  module Criteria
    module Job
      class Details
        extend Cb::Utils::FluidAttributes

        fluid_attr_accessor :did, :show_job_skin, :site_id, :lhs, :cobrand, :show_apply_requirements, :show_custom_values
      end
    end
  end
end