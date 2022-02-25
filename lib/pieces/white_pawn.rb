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

  def define_en_passant_square(move)
    up(position) if double_move_executed?(move)
  end

  private

  def double_move?
    position[1] == '2'
  end

  def double_move_executed?(move)
    position[1] == '2' && move[1] == '4'
  end
end
