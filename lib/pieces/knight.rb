# frozen_string_literal: true

# Knight subclass to model behavior of the Knight chess piece
class Knight < Piece
  def initialize(color:, position:)
    super
    @name = 'knight'
  end

  def self.handles_notation?(char)
    %w[N n].include?(char)
  end

  def moves
    [KnightMoves]
  end

  def to_s
    color == 'white' ? "\u2658" : "\u265E"
  end
end
