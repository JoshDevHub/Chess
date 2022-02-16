# frozen_string_literal: true

# King subclass to model behavior of the King Chess piece
class King < Piece
  def initialize(color:, position:)
    super
    @name = 'king'
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
    %w[K k].include?(char)
  end
end
