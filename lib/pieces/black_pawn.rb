# frozen_string_literal: true

# class for handling pawns with the color black
class BlackPawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  def moveset
    [%i[down]]
  end

  def self.handles_notation?(char)
    char == 'p'
  end
end
