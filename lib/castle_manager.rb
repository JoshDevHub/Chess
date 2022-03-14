# frozen_string_literal: true

# class for tracking castling availability
class CastleManager
  def initialize(castle_options: {
    white_king_side: false,
    white_queen_side: false,
    black_king_side: false,
    black_queen_side: false
  })
    @castle_options = castle_options
  end

  def can_castle?(color, side)
    key = "#{color}_#{side}_side".to_sym
    @castle_options[key]
  end

  def castle_rights_for_color?(color)
    can_castle?(color, :king) || can_castle?(color, :queen)
  end

  def remove_castle_option(color, side)
    key = "#{color}_#{side}_side".to_sym
    @castle_options[key] = false
  end

  def remove_all_castles_for_color(color)
    remove_castle_option(color, :king)
    remove_castle_option(color, :queen)
  end

  def handle_castling(piece, target, board)
    if piece.castle_move?(target)
      rook_origin, rook_target = rook_castle_move_map[target.to_sym]
      board.move_piece(rook_origin, rook_target)
    end
    piece.disable_castle_rights(self)
  end

  private

  def rook_castle_move_map
    {
      C1: %w[A1 D1],
      G1: %w[H1 F1],
      C8: %w[A8 D8],
      G8: %w[H8 F8]
    }
  end
end
