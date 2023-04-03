# frozen_string_literal: true

# class for representing the cells contained on a chess board
class Square
  include Coordinate
  using ColorableStrings

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
    string.fg_color(:black).bg_color(bg_color_name)
  end

  def to_string_with_moves(move_list)
    if move_list.none?(name)
      to_s
    elsif unoccupied?
      string = " \u2022 "
      string.fg_color(:black).bg_color(bg_color_name)
    else
      string = piece.to_s
      string.fg_color(:black).bg_color(:red)
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

  def bg_color_name
    x_coord, y_coord = to_xy_coordinate(name)
    (x_coord + y_coord).even? ? :gray : :purple
  end
end
