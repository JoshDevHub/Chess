# frozen_string_literal: true

# Pawn subclass to model behavior of the Pawn chess piece
class Pawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  def self.handles_notation?(char)
    %w[P p].include?(char)
  end

  def moveset
    moves = []
    color == 'white' ? moves.push(%i[up]) : moves.push(%i[down])
    moves
  end
end
