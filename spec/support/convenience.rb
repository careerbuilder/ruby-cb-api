module Cb
  module SpecSupport
    module Convenience

      def anything
        /.*/
      end

      def uri_stem(uri_stem_to_match)
        /#{uri_stem_to_match}*/
      end

    end
  end
end
