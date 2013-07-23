module Cb
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
        def generate_style style, value
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