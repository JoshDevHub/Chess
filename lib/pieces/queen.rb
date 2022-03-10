# frozen_string_literal: true

# Queen subclass to model behavior of the Queen chess piece
class Queen < Piece
  def initialize(color:, position:)
    super
    @name = 'queen'
  end

  def self.handles_notation?(char)
    %w[Q q].include?(char)
  end

  def moves
    [DiagonalLineMove, CardinalLineMove]
  end

  def to_s
    color == 'white' ? " \u2655 " : " \u265B "
  end
end
