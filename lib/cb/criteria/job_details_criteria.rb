module Cb
	class JobDetailsCriteria
	  extend Cb::Utils::FluidAttributes

	  fluid_attr_accessor :did, :show_job_skin, :site_id, :lhs, :cobrand, :show_apply_requirements,
                        :show_custom_values

	  def find
	    Cb.job.find_by_criteria(self)
	  end 
	end
end