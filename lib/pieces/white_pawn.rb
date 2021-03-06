# frozen_string_literal: true

# class for handling pawns with the color white
class WhitePawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  FEN_CHARS = { white: 'P' }.freeze
  UNICODES = { white: "\u2659" }.freeze

  def moves
    list = [WhitePawnAdvance, WhitePawnCapture]
    list << WhitePawnDoubleAdvance if double_move?
    list
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

  def move_resets_clock?
    true
  end

  private

  def double_move?
    position[1] == '2'
  end

  def double_move_executed?(move)
    position[1] == '2' && move[1] == '4'
  end
end
