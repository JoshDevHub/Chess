# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  def initialize(color:)
    @color = color
  end

  def self.create(piece:, color:)
    case piece
    when :king
      King.new(color: color)
    when :queen
      Queen.new(color: color)
    when :bishop
      Bishop.new(color: color)
    when :rook
      Rook.new(color: color)
    when :knight
      Knight.new(color: color)
    when :pawn
      Pawn.new(color: color)
    end
  end
end
