# frozen_string_literal: true

# class for parsing Forsyth-Edwards Notation
class FEN
  include Coordinate

  attr_reader :fen_string

  def initialize(fen_string, piece)
    @fen_string = fen_string
    @piece = piece
  end

  def piece_info
    info = fen_string.split(' ')[0].chars.map(&empty_expand).join('').split('/')
    pieces = []
    info.each_with_index do |rank, y|
      rank.each_char.with_index do |chr, x|
        square_name = to_square_notation([x, y])
        pieces << @piece.from_fen(chr, square_name) unless chr == '.'
      end
    end
    pieces
  end

  def active_color
    color_info = fen_string.split(' ')[1]
    color_info == 'w' ? 'white' : 'black'
  end

  def castle_info
    # placeholder
  end

  def en_passant_target
    en_passant_square = fen_string.split(' ')[3]
    en_passant_square == '-' ? nil : en_passant_square.upcase
  end

  def half_move_clock
    clock = fen_string.split(' ')[4]
    clock.to_i
  end

  def full_move_clock
    clock = fen_string.split(' ')[5]
    clock.to_i
  end

  private

  def empty_expand
    ->(square) { square.to_i.positive? ? '.' * square.to_i : square }
  end
end
