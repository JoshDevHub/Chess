# frozen_string_literal: true

# Pawn superclass that manages the behavior of pawn pieces
class Pawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  def self.handles_notation?(char)
    %w[P p].include?(char)
  end

  def generate_moves(board)
    captures = capture_moves(board)
    if possible_double_move?
      double_move(board) + captures
    else
      single_move(board) + captures
    end
  end

  private

  def legal_move?(move, board)
    valid_square?(move) && board.square_empty?(move)
  end

  def double_move(board)
    move_list = []
    first_move = send(moveset, @position)
    if legal_move?(first_move, board)
      move_list << first_move
      second_move = send(moveset, first_move)
      move_list << second_move if legal_move?(second_move, board)
    end
    move_list
  end

  def single_move(board)
    move_list = []
    move = send(moveset, @position)
    move_list << move if legal_move?(move, board)
    move_list
  end

  def capture_moves(board)
    move_list = []
    capture_moveset.each do |move|
      possible_move = move.reduce(@position) { |current, step| send(step, current) }
      move_list << possible_move if board.color_at(possible_move) == opponent_color
    end
    move_list
  end

  def possible_double_move?
    !@moved
  end
end
