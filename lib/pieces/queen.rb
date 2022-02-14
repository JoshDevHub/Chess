# frozen_string_literal: true

# Queen subclass to model behavior of the Queen chess piece
class Queen < Piece
  def initialize(color:)
    super
    @name = 'queen'
  end

  def self.handles_notation?(char)
    %w[Q q].include?(char)
  end

  def line_moves?
    true
  end

  private

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
