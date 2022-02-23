# frozen_string_literal: true

# class for generating one north move in accordance to needs of White Pawn
class OneUpMove < Move
  def moveset
    [
      %i[up]
    ]
  end

  private

  def legal_move?(square)
    valid_square?(square) && @board.square_empty?(square)
  end
end
