# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  attr_reader :color, :name, :moved

  def initialize(color:)
    raise NotImplementedError unless COLORS.include?(color)

    @color = color
    @name = 'piece'
    @moved = false
  end

  COLORS = %w[white black].freeze

  def to_s
    "#{color} #{name}"
  end

  def opponent_color
    color == 'white' ? 'black' : 'white'
  end

  def self.from_fen(char)
    color = char == char.upcase ? 'white' : 'black'
    [King, Queen, Rook, Bishop, Knight, Pawn]
      .find { |piece_type| piece_type.handles_notation?(char) }.new(color: color)
  rescue NoMethodError
    puts 'This piece is not supported'
    raise NotImplementedError
  end

  def implemented_moves
    %i[moves_diagonally? moves_horizontally? knight_moves? moves_up? moves_down?]
      .select { |move| send(move) }
  end

  def piece_moved
    @moved = true
  end

  def line_moves?
    false
  end

  private

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
end
