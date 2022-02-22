# frozen_string_literal: true

# Bishop subclass to model behavior of the Bishop Chess piece
class Bishop < Piece
  def initialize(color:, position:)
    super
    @name = 'bishop'
    @moves = DiagonalLineMove
  end

  def self.handles_notation?(char)
    %w[B b].include?(char)
  end

  def to_s
    color == 'white' ? "\u2657" : "\u265D"
  end
end
