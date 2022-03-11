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
end
