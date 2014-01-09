module Cb
  module Criteria
    module Application
      class Resume
        extend Cb::Utils::FluidAttributes
        fluid_attr_accessor :external_resume_id, :resume_file_name, :resume_data, :resume_extension, :resume_title
      end
    end
  end
end
