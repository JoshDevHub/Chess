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
    info.each_with_object([]).with_index do |(rank, pieces), y_coord|
      row_info = parse_ranks(rank, y_coord)
      pieces.concat(row_info)
    end
  end

  def active_color
    color_info = fen_string.split(' ')[1]
    color_info == 'w' ? 'white' : 'black'
  end

  def castle_info
    # placeholder
  end

  def en_passant_target
    en_passant_square = fen_string.split(' ')[3].upcase
    en_passant_square unless en_passant_square == '-'
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

  def parse_ranks(rank, y_coord)
    pieces = []
    rank.each_char.with_index do |chr, x_coord|
      square_name = to_square_notation([x_coord, y_coord])
      pieces << @piece.from_fen(chr, square_name) unless chr == '.'
    end
    pieces
  end

  def empty_expand
    lambda do |character|
      character_to_number = character.to_i
      character_to_number.positive? ? '.' * character_to_number : character
    end
  end
end
