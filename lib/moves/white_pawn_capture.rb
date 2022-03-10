# frozen_string_literal: true

# Move subclass for White Pawn capture moves
class WhitePawnCapture < Move
  def moveset
    [
      %i[up right],
      %i[up left]
    ]
  end

  private

  def legal_move?(square)
    return false unless valid_square?(square)

    board_square = board.access_square(square)
    board_square.piece_color == opposing_color || capture_en_passant?(square)
  end

  def capture_en_passant?(square)
    board.en_passant_target == square && square[1] == '6'
  end
end
