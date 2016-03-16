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
    module FluidAttributes
      def fluid_attr_accessor(*names)
        names.each do |name|
          define_method :"#{name}" do |*args|
            return instance_variable_get(:"@#{name}") if args.length == 0

            if args.length == 1
              instance_variable_set(:"@#{name}", args[0])
              return self
            end

            fail ArgumentError.new("Wrong number of arguments (#{args.length} for 1)")
          end

          define_method :"#{name}=" do |*args|
            instance_variable_set(:"@#{name}", args[0]) if args.length == 1
            return self
          end
        end
      end
    end
  end
end
