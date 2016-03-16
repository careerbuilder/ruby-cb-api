# Copyright 2016 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module Cb
  module Utils
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
            define_singleton_method "#{country}" do
              return country
            end
          end
        end
      end
    end
  end
end
