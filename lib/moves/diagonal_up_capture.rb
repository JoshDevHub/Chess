# frozen_string_literal: true

# Move subclass for White Pawn capture moves
class DiagonalUpCapture < Move
  def moveset
    [
      %i[up right],
      %i[up left]
    ]
  end

  private

  def legal_move?(square)
    valid_square?(square) && @board.color_at(square) == opposing_color
  end
end
