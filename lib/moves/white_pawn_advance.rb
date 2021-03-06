# frozen_string_literal: true

# class for generating one north move in accordance to needs of White Pawn
class WhitePawnAdvance < Move
  def moveset
    [
      %i[up]
    ]
  end

  private

  def legal_move?(square)
    return false unless valid_square?(square)

    board_square = board.access_square(square)
    board_square.unoccupied?
  end
end
