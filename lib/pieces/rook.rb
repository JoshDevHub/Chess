# frozen_string_literal: true

# Rook subclass to model behavior of the Rook chess piece
class Rook < Piece
  def initialize(color:, position:)
    super
    @name = 'rook'
    @moves = [CardinalLineMove]
  end

  def self.handles_notation?(char)
    %w[R r].include?(char)
  end

  def to_s
    color == 'white' ? "\u2656" : "\u265C"
  end
end
