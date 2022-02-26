# frozen_string_literal: true

# class that manages one down move in accordance with needs of Black Pawns
class BlackPawnAdvance < Move
  def moveset
    [
      %i[down]
    ]
  end

  private

  def legal_move?(square)
    valid_square?(square) && @board.square_empty?(square)
  end
end
