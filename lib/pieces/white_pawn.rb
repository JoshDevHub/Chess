# frozen_string_literal: true

# class for handling pawns with the color white
class WhitePawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  def self.handles_notation?(char)
    char == 'P'
  end

  def moves
    list = [OneUpMove, DiagonalUpCapture]
    list << DoubleUpMove if double_move?
    list
  end

  def to_s
    "\u2659"
  end

  private

  def double_move?
    position[1] == '2'
  end
end
