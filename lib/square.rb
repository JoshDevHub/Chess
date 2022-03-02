# frozen_string_literal: true

# class for representing the cells contained on a chess board
class Square
  attr_reader :name, :piece

  def initialize(name:, piece: nil)
    @name = name
    @piece = piece
  end

  def unoccupied?
    @piece.nil?
  end

  def add_piece(piece)
    @piece = piece
  end
end
