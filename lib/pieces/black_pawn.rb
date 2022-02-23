# frozen_string_literal: true

# class for handling pawns with the color black
class BlackPawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  def self.handles_notation?(char)
    char == 'p'
  end

  def moves
    list = [OneDownMove, DiagonalDownCapture]
    list << DoubleDownMove if double_move?
    list
  end

  def to_s
    "\u265F"
  end

  private

  def double_move?
    position[1] == '7'
  end
end
