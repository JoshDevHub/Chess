# frozen_string_literal: true

# class that generates moves for a King piece
class KingMove < Move
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
end
