# frozen_string_literal: true

# class that manages generation of moves
class Move
  include Coordinate

  def initialize(origin:, board:, color:)
    @origin = origin
    @board = board
    @color = color
  end

  def moveset
    []
  end

  def generate_moves
    moveset.each_with_object([]) do |move, list|
      possible_moves = path_from(move)
      list.concat(possible_moves)
    end
  end

  private

  def path_from(square)
    path = []
    current_square = @origin
    loop do
      new_move = square.reduce(current_square) { |current, step| send(step, current) }
      break unless legal_move?(new_move)

      path << new_move
      break unless line_moves?

      current_square = new_move
    end
    path
  end

  def legal_move?(square)
    valid_square?(square) && (@board.square_empty?(square) || @board.color_at(square) != @color)
  end

  def line_moves?
    false
  end

  def opposing_color
    @color == 'white' ? 'black' : 'white'
  end
end
