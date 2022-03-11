# frozen_string_literal: true

# Rook subclass to model behavior of the Rook chess piece
class Rook < Piece
  def initialize(color:, position:)
    super
    @name = 'rook'
  end

  def self.handles_notation?(char)
    %w[R r].include?(char)
  end

  def moves
    [CardinalLineMove]
  end

  def to_s
    color == 'white' ? " \u2656 " : " \u265C "
  end

  def involved_in_castling?
    rank = color == 'white' ? '1' : '8'
    position == "A#{rank}" || position == "H#{rank}"
  end
end
