# frozen_string_literal: true

# class for White Pawn's initial double move ability
class DoubleUpMove < Move
  def moveset
    [
      %i[up up]
    ]
  end

  def legal_move?(square)
    pass_through_square = down(square)
    valid_square?(square) && @board.square_empty?(square) &&
      @board.square_empty?(pass_through_square)
  end
end
