# frozen_string_literal: true

# Pawn subclass to model behavior of the Pawn chess piece
class Pawn < Piece
  def initialize(color:)
    super
  end

  def self.handles_notation?(char)
    %w[P p].include?(char)
  end
end
