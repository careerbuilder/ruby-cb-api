module Cb
  module Criteria
    module Resumes
      class GetByHash
        extend Cb::Utils::FluidAttributes

        fluid_attr_accessor :resume_hash, :external_user_id

        def initialize(args = {})
          @resume_hash        = args[:resumeHash] || ''
          @external_user_id        = args[:externalUserID] || ''
        end

        def to_hash
          { :resume_hash => @resume_hash, :external_user_id => @external_user_id }
        end

        alias :to_h :to_hash
      end
    end
  end
end