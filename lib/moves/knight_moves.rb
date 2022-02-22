# frozen_string_literal: true

# subclass for managing knight's moves
class KnightMoves < Move
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
end
