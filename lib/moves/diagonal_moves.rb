# frozen_string_literal: true

# subclass to generate diagonal moves
class DiagonalMoves < Move
  MOVESET = [
    %i[up right],
    %i[up left],
    %i[down left],
    %i[down right]
  ].freeze
end
