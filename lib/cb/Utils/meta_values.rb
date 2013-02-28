module Cb::Utils
  class MetaValues
    # This class will be dynamically constructed at run time.
    # I don't want values that don't make sense to the API call you made to be accessible
    # I'm not dynamically creating the class because we may want to add functionality at some point

    # This class, with its dynamically created attr_accr's will be dynamically appended to api
    # entities, like job and company. It will contain things like errors, time elapsed, and
    # any other meta values that the API may return.

    # The mapping for allowed values, and what they translate to on this object live in Cb::Utils::Api
  end
end
