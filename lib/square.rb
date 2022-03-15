# frozen_string_literal: true

require_relative 'colorize_output'

# class for representing the cells contained on a chess board
class Square
  include Coordinate
  include ColorizeOutput

  attr_reader :name

  def initialize(name:, piece: nil)
    @name = name
    @piece = piece
    @null_piece = NullPiece.new
  end

  def piece
    @piece ||= @null_piece
  end

  def to_s(_move_list = nil)
    string = piece.to_s
    bg_color(fg_black(string))
  end

  def to_string_with_moves(move_list)
    if move_list.none?(name)
      to_s
    elsif unoccupied?
      string = " \u2022 "
      bg_color(fg_black(string))
    else
      string = piece.to_s
      bg_red(fg_black(string))
    end
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
    (x_coord + y_coord).even? ? bg_gray(string) : bg_purple(string)
  end
end
