# frozen_string_literal: true

# class for handling pawns with the color white
class WhitePawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  def moveset
    [%i[up]]
  end

  def self.handles_notation?(char)
    char == 'P'
  end
end
