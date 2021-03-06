# frozen_string_literal: true

# King subclass to model behavior of the King Chess piece
class King < Piece
  def initialize(color:, position:)
    super
    @name = 'king'
  end

  FEN_CHARS = { white: 'K', black: 'k' }.freeze
  UNICODES = { white: "\u2654", black: "\u265A" }.freeze

  def moves
    [KingMove, KingSideCastle, QueenSideCastle]
  end

  def involved_in_castling?
    rank = color == 'white' ? '1' : '8'
    position == "E#{rank}"
  end

  def disable_castle_rights(castle_manager)
    castle_manager.remove_all_castles_for_color(color)
  end

  def castle_move?(target)
    rank = color == 'white' ? '1' : '8'
    castle_origin, *castle_targets = %w[E C G].map { |file| file + rank }
    position == castle_origin && castle_targets.include?(target)
  end
end
