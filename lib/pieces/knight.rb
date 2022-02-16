# frozen_string_literal: true

# Knight subclass to model behavior of the Knight chess piece
class Knight < Piece
  def initialize(color:, position:)
    super
    @name = 'knight'
  end

  MOVESET = [
    %i[up up right],
    %i[up up left],
    %i[down down right],
    %i[down down left],
    %i[left left up],
    %i[left left down],
    %i[right right up],
    %i[right right down]
  ].freeze

  def self.handles_notation?(char)
    %w[N n].include?(char)
  end
end
