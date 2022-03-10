# frozen_string_literal: true

# class that manages one down move in accordance with needs of Black Pawns
class BlackPawnAdvance < Move
  def moveset
    [
      %i[down]
    ]
  end

  private

  def legal_move?(square)
    return false unless valid_square?(square)

    board_square = board.access_square(square)
    board_square.unoccupied?
  end
end
