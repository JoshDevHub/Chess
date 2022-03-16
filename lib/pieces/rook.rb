# frozen_string_literal: true

# Rook subclass to model behavior of the Rook chess piece
class Rook < Piece
  def initialize(color:, position:)
    super
    @name = 'rook'
  end

  FEN_CHARS = { white: 'R', black: 'r' }.freeze
  UNICODES = { white: "\u2656", black: "\u265C" }.freeze

  def moves
    [CardinalLineMove]
  end

  def to_s
    color == 'white' ? " \u2656 " : " \u265C "
  end

  def involved_in_castling?
    rank = color == 'white' ? '1' : '8'
    position == "A#{rank}" || position == "H#{rank}"
  end

  def disable_castle_rights(castle_manager)
    file = position[0].to_sym
    side = { A: :queen, H: :king }[file]
    return unless side

    castle_manager.remove_castle_option(color, side)
  end
end
