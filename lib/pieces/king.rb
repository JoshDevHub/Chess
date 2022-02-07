# frozen_string_literal: true

# King subclass to model behavior of the King Chess piece
class King < Piece
  def initialize(color:)
    super
    @name = 'king'
  end

  def self.handles_notation?(char)
    %w[K k].include?(char)
  end

  def moves_diagonally?
    true
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
end
