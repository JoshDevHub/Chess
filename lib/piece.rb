# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  attr_accessor :position

  attr_reader :color, :name, :en_passant_target

  include Coordinate

  def initialize(color:, position:)
    raise NotImplementedError unless COLORS.include?(color)

    @color = color
    @position = position
    @name = 'piece'
    @en_passant_target = nil
  end

  COLORS = %w[white black].freeze

  def moves
    []
  end

  def move_list(board)
    moves.each_with_object([]) do |move, list|
      generator = move.new(origin: position, board: board, color: color)
      list.concat(generator.generate_moves)
    end
  end

  def to_s
    "#{color} #{name}"
  end

  def opponent_color
    color == 'white' ? 'black' : 'white'
  end

  def self.from_fen(char, square)
    color = char == char.upcase ? 'white' : 'black'
    [King, Queen, Rook, Bishop, Knight, WhitePawn, BlackPawn]
      .find { |piece_type| piece_type.handles_notation?(char) }.new(color: color, position: square)
  rescue NoMethodError
    puts 'This piece is not supported'
    raise NotImplementedError
  end

  def define_en_passant_square(_square)
    nil
  end

  def capture_en_passant?(_square)
    false
  end

  def can_promote?
    false
  end

  private

  def double_move?
    false
  end
end
