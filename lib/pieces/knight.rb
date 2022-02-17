# frozen_string_literal: true

# Knight subclass to model behavior of the Knight chess piece
class Knight < Piece
  def initialize(color:, position:)
    super
    @name = 'knight'
  end

  def moveset
    [
      %i[up up right],
      %i[up up left],
      %i[down down right],
      %i[down down left],
      %i[left left up],
      %i[left left down],
      %i[right right up],
      %i[right right down]
    ]
  end

  def self.handles_notation?(char)
    %w[N n].include?(char)
  end

  def to_s
    color == 'white' ? "\u2658" : "\u265E"
  end
end
