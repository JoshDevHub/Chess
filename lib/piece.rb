# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  attr_reader :color

  def initialize(color:)
    raise NotImplementedError unless COLORS.include?(color)

    @color = color
  end

  COLORS = %w[white black].freeze

  def self.from_fen(char)
    color = char == char.upcase ? 'white' : 'black'
    [King, Queen, Rook, Bishop, Knight, Pawn]
      .find { |piece_type| piece_type.handles_notation?(char) }.new(color: color)
  end

  def moves_diagonally?
    false
  end

  def moves_horizontally?
    false
  end

  def knight_moves?
    false
  end

  def moves_up?
    false
  end

  def moves_down?
    false
  end

  def line_moves?
    false
  end
end
