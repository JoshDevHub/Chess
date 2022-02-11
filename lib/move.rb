# frozen_string_literal: true

# class to represent the concept of a chess move
class Move
  include Coordinate
  attr_reader :board

  def initialize(board:, piece:)
    @board = board
    @piece = piece
  end

  MOVESET = [].freeze

  def legal_move?(move)
    valid_square?(move) && (board.square_empty?(move) || capture_move?(move))
  end

  def capture_move?(move)
    board.piece_at(move).color != @piece.color
  end

  def generate_moves(square)
    move_list = []
    self.class::MOVESET.each do |move|
      move_list += path_from(move, square)
    end
    move_list
  end

  private

  def path_from(move, origin)
    current_square = origin
    path = []
    loop do
      new_move = move.reduce(current_square) { |current, step| send(step, current) }
      break unless legal_move?(new_move)

      path << new_move
      break unless @piece.line_moves?

      current_square = new_move
    end
    path
  end
end
