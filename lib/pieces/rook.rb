# frozen_string_literal: true

# Rook subclass to model behavior of the Rook chess piece
class Rook < Piece
  def initialize(color:)
    super
    @name = 'rook'
  end

  def self.handles_notation?(char)
    %w[R r].include?(char)
  end

  def line_moves?
    true
  end

  private

  def moves_horizontally?
    true
  end

  def moves_up?
    true
  end

  def moves_down?
    true
  end
end
