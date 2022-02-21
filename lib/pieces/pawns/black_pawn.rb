# frozen_string_literal: true

# class for handling pawns with the color black
class BlackPawn < Pawn
  def moveset
    :down
  end

  def capture_moveset
    [%i[down left], %i[down right]]
  end

  def self.handles_notation?(char)
    char == 'p'
  end

  def to_s
    "\u265F"
  end

  private

  def possible_double_move?
    position[1] == '7'
  end
end
