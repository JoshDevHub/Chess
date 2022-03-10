# frozen_string_literal: true

# class for representing the cells contained on a chess board
class Square
  include Coordinate

  attr_reader :name

  def initialize(name:, piece: nil)
    @name = name
    @piece = piece
    @null_piece = NullPiece.new
  end

  def piece
    @piece ||= @null_piece
  end

  def to_s
    string = piece.to_s
    darken_string = fg_black(string)
    bg_color(darken_string)
  end

  def unoccupied?
    piece.absent?
  end

  def add_piece(piece)
    @piece = piece
  end

  def remove_piece
    piece_to_remove = piece
    @piece = @null_piece
    piece_to_remove
  end

  def piece_color
    piece.color
  end

  def occupied_by_king?(color)
    piece.name == 'king' && piece.color == color
  end

  private

  def bg_color(string)
    x_coord, y_coord = to_xy_coordinate(name)
    (x_coord + y_coord).even? ? bg_gray(string) : bg_magenta(string)
  end

  def fg_black(string)
    "\e[30m#{string}\e[0m"
  end

  def bg_gray(string)
    "\e[47m#{string}\e[0m"
  end

  def bg_magenta(string)
    "\e[48;2;136;119;183m#{string}\e[0m"
  end
end
