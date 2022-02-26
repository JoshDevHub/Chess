# frozen_string_literal: true

# Move subclass for Black Pawn capture moves
class BlackPawnCapture < Move
  def moveset
    [
      %i[down right],
      %i[down left]
    ]
  end

  private

  def legal_move?(square)
    valid_square?(square) && @board.color_at(square) == opposing_color
  end
end
