require 'json'

module Cb
  module Clients
    class Job
      class << self
        def find_by_criteria(criteria)
        end

        def find_by_did(did)
          criteria = Cb::Criteria::Job::Details.new
          criteria.did = did
          criteria.show_custom_values = true
          find_by_criteria(criteria)
        end
      end
    end
  end
end
