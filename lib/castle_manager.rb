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
end
