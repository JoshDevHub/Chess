# frozen_string_literal: true

# class for representing the cells contained on a chess board
class Square
  attr_reader :name, :piece

  def initialize(name:, piece: nil)
    @name = name
    @piece = piece
  end

  def to_s
    if unoccupied?
      '    '
    else
      " #{piece}  "
    end
  end

  def unoccupied?
    @piece.nil?
  end

  def add_piece(piece)
    @piece = piece
  end

  def remove_piece
    return if unoccupied?

    piece_to_remove = @piece
    @piece = nil
    piece_to_remove
  end

  def rank
    name[1]
  end

  def file
    name[0]
  end
end
