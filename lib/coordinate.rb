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
    x, y = square_notation.chars
    [FILE_NAMES.index(x), RANK_NAMES.index(y)]
  end

  def valid_square?(square)
    square.size == 2 && square.start_with?(*FILE_NAMES) &&
      square.end_with?(*RANK_NAMES)
  end

  def up(square)
    target_square = square[0] + square[1].succ
    valid_square?(target_square) ? target_square : nil
  end

  def down(square)
    target_square = square[0] + (square[1].ord - 1).chr
    valid_square?(target_square) ? target_square : nil
  end

  def right(square)
    target_square = square[0].succ + square[1]
    valid_square?(target_square) ? target_square : nil
  end

  def left(square)
    target_square = (square[0].ord - 1).chr + square[1]
    valid_square?(target_square) ? target_square : nil
  end
end
