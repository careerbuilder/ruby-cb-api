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
  module Models
    module Branding
      module Styles
        module CssAdapter
          def to_css
            css = ''
            @styles.each do |style, value|
              css += generate_style style, value
            end
            css
          end

          private

          def generate_style(style, value)
            {
              'BackgroundColor' => "background-color: #{value};",
              'BackgroundImage' => "background-image: url(#{value});",
              'BackgroundGradient' => "background: #{value['Color1']};
                          background: -moz-linear-gradient(#{value['Orientation'] == 'Vertical' ? 'top' : 'left'}, #{value['Color1']} 0%, #{value['Color2']} 100%);
                          background: -webkit-gradient(linear, left top, #{value['Orientation'] == 'Vertical' ? 'left bottom' : 'right top'}, color-stop(0%,#{value['Color1']}), color-stop(100%,#{value['Color2']}));
                          background: -webkit-linear-gradient(#{value['Orientation'] == 'Vertical' ? 'top' : 'left'}, #{value['Color1']} 0%,#{value['Color2']} 100%);
                          background: -o-linear-gradient(#{value['Orientation'] == 'Vertical' ? 'top' : 'left'}, #{value['Color1']} 0%,#{value['Color2']} 100%);
                          background: -ms-linear-gradient(#{value['Orientation'] == 'Vertical' ? 'top' : 'left'}, #{value['Color1']} 0%,#{value['Color2']} 100%);
                          background: linear-gradient(to #{value['Orientation'] == 'Vertical' ? 'bottom' : 'right'}, #{value['Color1']} 0%,#{value['Color2']} 100%);
                          filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#{value['Color1']}', endColorstr='#{value['Color2']}',GradientType=#{value['Orientation'] == 'Vertical' ? '0' : '1'} );",
              'BorderSize' => "border-width: #{value};",
              'BorderColor' => "border-color: #{value};",
              'BorderRadius' => "-webkit-border-radius: #{value};
                        -moz-border-radius: #{value};
                        border-radius: #{value};",
              'BoxShadow' => "-webkit-box-shadow: #{value};
                       -moz-box-shadow: #{value};
                       box-shadow: #{value};",
              'FontColor' => "color: #{value};",
              'FontSize' => "font-size: #{value};",
              'FontStyle' => "font-family: #{value};"
            }[style].gsub(/\s+/, '')
          end
        end
      end
    end
  end
end
