# frozen_string_literal: true

# class for parsing Forsyth-Edwards Notation
class FEN
  include Coordinate

  attr_reader :fen_string

  def initialize(fen_string)
    @fen_string = fen_string
  end

  def square_info(square)
    board_rep = fen_string.split(' ')[0].chars.map(&empty_expand).join('').split('/')
    x, y = to_xy_coordinate(square)
    board_rep[y][x] == '.' ? nil : board_rep[y][x]
  end

  def active_color
    # placeholder
  end

  def castle_info
    # placeholder
  end

  def en_passant_target
    # placeholder
  end

  def clock_info
    # placeholder
  end

  private

  def empty_expand
    ->(square) { square.to_i.positive? ? '.' * square.to_i : square }
  end
end
