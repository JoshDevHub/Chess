# frozen_string_literal: true

# class for parsing Forsyth-Edwards Notation
class FEN
  attr_reader :fen_string

  def initialize(fen_string)
    @fen_string = fen_string
  end

  def piece_info
    # placeholder
  end

  def active_color
    # placeholder
  end

  def castle_info
    # placeholder
  end

  def en_passant_target
    # placeholder
  end

  def clock_info
    # placeholder
  end
end
