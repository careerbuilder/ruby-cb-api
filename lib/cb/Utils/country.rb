module Cb::Utils
  class Country
    # These aren't all country codes. We get it. Our naming scheme didn't hold up over time.
    def self.get_supported
      %w(AH BE CA CC CE CH CN CP CS CY DE DK E1 ER ES EU F1
       FR GC GR I1 IE IN IT J1 JC JS LJ M1 MY NL NO PD PI
       PL RM RO RX S1 SE SF SG T1 T2 UK US WH WM WR)
    end

    def self.is_valid?(country)
      get_supported.include? country
    end

    def self.inject_convenience_methods
      get_supported.each do |country|
        unless self.respond_to? "#{country}"
          self.define_singleton_method "#{country}" do
            return country
          end
        end
      end
    end
  end
end