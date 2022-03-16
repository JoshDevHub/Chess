# frozen_string_literal: true

# module for providing utility methods to color string output in terminal display
module ColorizeOutput
  # background colors
  def bg_purple(string)
    "\e[48;2;136;119;183m#{string}\e[0m"
  end

  def bg_gray(string)
    "\e[47m#{string}\e[0m"
  end

  def bg_red(string)
    "\e[41m#{string}\e[0m"
  end

  # foreground colors
  def fg_black(string)
    "\e[30m#{string}\e[0m"
  end
end