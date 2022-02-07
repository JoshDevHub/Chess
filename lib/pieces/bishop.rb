# frozen_string_literal: true

# Bishop subclass to model behavior of the Bishop Chess piece
class Bishop < Piece
  def self.handles_notation?(char)
    %w[B b].include?(char)
  end

  def moves_diagonally?
    true
  end

  def line_moves?
    true
  end
end
