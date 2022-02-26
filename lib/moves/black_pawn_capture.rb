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
    valid_square?(square) &&
      (@board.color_at(square) == opposing_color || capture_en_passant?(square))
  end

  def capture_en_passant?(square)
    @board.en_passant_target == square && square[1] == '3'
  end
end
