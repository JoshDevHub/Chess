# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  attr_accessor :position

  attr_reader :color, :name, :moved

  include Coordinate

  def initialize(color:, position:)
    raise NotImplementedError unless COLORS.include?(color)

    @color = color
    @position = position
    @name = 'piece'
    @moved = false
  end

  COLORS = %w[white black].freeze

  def moveset
    []
  end

  def generate_moves(board)
    move_list = []
    moveset.each do |move|
      move_list += path_from(move, board)
    end
    move_list
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

  def piece_moved
    @moved = true
  end

  private

  def legal_move?(move, board)
    valid_square?(move) && (board.square_empty?(move) || board.color_at(move) == opponent_color)
  end

  def path_from(move, board)
    path = []
    current_square = @position
    loop do
      new_move = move.reduce(current_square) { |current, step| send(step, current) }
      break unless legal_move?(new_move, board)

      path << new_move
      break unless line_moves?

      current_square = new_move
    end
    path
  end

  def line_moves?
    false
  end
end
