module Cb
  module SpecSupport
    module Convenience

      def anything
        /.*/
      end

      def base_string(str)
        /#{str}*/
      end

    end
  end
end
