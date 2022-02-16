# frozen_string_literal: true

# class for handling pawns with the color white
class WhitePawn < Pawn
  def moveset
    :up
  end

  def capture_moveset
    [%i[up left], %i[up right]]
  end

  def self.handles_notation?(char)
    char == 'P'
  end
end
