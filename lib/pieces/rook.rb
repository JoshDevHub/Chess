# frozen_string_literal: true

# Rook subclass to model behavior of the Rook chess piece
class Rook < Piece
  def self.handles_notation?(char)
    %w[R r].include?(char)
  end

  def moves_horizontally?
    true
  end

  def moves_up?
    true
  end

  def moves_down?
    true
  end

  def line_moves?
    true
  end
end
