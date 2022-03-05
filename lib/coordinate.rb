# frozen_string_literal: true

# module for handling coordinates in a 2d plane
module Coordinate
  FILE_NAMES = %w[A B C D E F G H].freeze
  RANK_NAMES = %w[8 7 6 5 4 3 2 1].freeze

  def to_square_notation(coordinate)
    file_index, rank_index = coordinate
    FILE_NAMES[file_index] + RANK_NAMES[rank_index]
  end

  def to_xy_coordinate(square_notation)
    x_coord, y_coord = square_notation.chars
    [FILE_NAMES.index(x_coord), RANK_NAMES.index(y_coord)]
  end

  def valid_square?(square)
    square.size == 2 && square.start_with?(*FILE_NAMES) &&
      square.end_with?(*RANK_NAMES)
  end

  def up(square)
    square[0] + square[1..-1].succ
  end

  def down(square)
    square[0] + (square[1..-1].ord - 1).chr
  end

  def right(square)
    square[0].succ + square[1..-1]
  end

  def left(square)
    (square[0].ord - 1).chr + square[1..-1]
  end
end
