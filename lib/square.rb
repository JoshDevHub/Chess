# frozen_string_literal: true

# class for individual squares on a chess board
class Square
  attr_reader :name, :piece

  def initialize(name:, piece: nil)
    @name = name
    @piece = piece
  end

  def empty?
    piece.nil?
  end

  def add_piece(piece)
    @piece = piece
  end

  def remove_piece
    @piece = nil
  end
end
