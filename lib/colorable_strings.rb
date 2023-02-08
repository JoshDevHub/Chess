# frozen_string_literal: true

# String refinements for adding color in terminal
module ColorableStrings
  RGB_COLOR_MAP = {
    black: '0;0;0',
    cyan: '139;233;253',
    gray: '204;204;204',
    purple: '136;119;183',
    red: '255;85;85',
    yellow: '241;250;140'
  }.freeze

  refine String do
    def fg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[38;2;#{rgb_val}m#{self}\e[0m"
    end

    def bg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[48;2;#{rgb_val}m#{self}\e[0m"
    end
  end
end
