# frozen_string_literal: true

# class for Black Pawn's initial double move ability
class DoubleDownMove < Move
  def moveset
    [
      %i[down down]
    ]
  end

  def legal_move?(square)
    pass_through_square = up(square)
    valid_square?(square) && @board.square_empty?(square) &&
      @board.square_empty?(pass_through_square)
  end
end
