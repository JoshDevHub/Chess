# frozen_string_literal: true

# Queen subclass to model behavior of the Queen chess piece
class Queen < Piece
  def initialize(color:, position:)
    super
    @name = 'queen'
  end

  def moveset
    [
      %i[up],
      %i[down],
      %i[left],
      %i[right],
      %i[up left],
      %i[up right],
      %i[down left],
      %i[down right]
    ]
  end

  def self.handles_notation?(char)
    %w[Q q].include?(char)
  end

  def to_s
    color == 'white' ? "\u2655" : "\u265B"
  end

  private

  def line_moves?
    true
  end
end
