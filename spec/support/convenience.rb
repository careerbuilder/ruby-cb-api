module Cb
  module SpecSupport
    module Convenience

      def uri_stem(uri_stem)
        /#{uri_stem}*/
      end

      def anything
        /.*/
      end

    end
  end
end
