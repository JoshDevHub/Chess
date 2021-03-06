# frozen_string_literal: true

# class for handling pawns with the color black
class BlackPawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  FEN_CHARS = { black: 'p' }.freeze
  UNICODES = { black: "\u265F" }.freeze

  def moves
    list = [BlackPawnAdvance, BlackPawnCapture]
    list << BlackPawnDoubleAdvance if double_move?
    list
  end

  def define_en_passant_square(move)
    down(position) if double_move_executed?(move)
  end

  def capture_en_passant?(square)
    square[1] == '3' if square
  end

  def can_promote?
    position[1] == '1'
  end

  def move_resets_clock?
    true
  end

  private

  def double_move?
    position[1] == '7'
  end

  def double_move_executed?(move)
    position[1] == '7' && move[1] == '5'
  end
end
