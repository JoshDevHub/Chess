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
    list = [WhitePawnAdvance, WhitePawnCapture]
    list << WhitePawnDoubleAdvance if double_move?
    list
  end

  def to_s
    "\u2659"
  end

  def define_en_passant_square(move)
    up(position) if double_move_executed?(move)
  end

  def capture_en_passant?(square)
    square[1] == '6' if square
  end

  def can_promote?
    position[1] == '8'
  end

  private

  def double_move?
    position[1] == '2'
  end

  def double_move_executed?(move)
    position[1] == '2' && move[1] == '4'
  end
end
