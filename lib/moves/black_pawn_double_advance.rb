# frozen_string_literal: true

# class for Black Pawn's initial double move ability
class BlackPawnDoubleAdvance < Move
  def moveset
    [
      %i[down down]
    ]
  end

  def legal_move?(square)
    return false unless valid_square?(square)

    board_square = @board.access_square(square)
    pass_through_square = @board.access_square(up(square))
    [board_square, pass_through_square].all?(&:unoccupied?)
  end
end
