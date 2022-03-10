# frozen_string_literal: true

# class for White Pawn's initial double move ability
class WhitePawnDoubleAdvance < Move
  def moveset
    [
      %i[up up]
    ]
  end

  def legal_move?(square)
    return false unless valid_square?(square)

    board_square = board.access_square(square)
    pass_through_square = board.access_square(down(square))
    [board_square, pass_through_square].all?(&:unoccupied?)
  end
end
