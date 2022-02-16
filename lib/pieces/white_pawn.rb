# frozen_string_literal: true

# class for handling pawns with the color white
class WhitePawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  def moveset
    :up
  end

  def self.handles_notation?(char)
    char == 'P'
  end

  def generate_moves(board)
    if possible_double_move?
      double_move(board)
    else
      single_move(board)
    end
  end

  private

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

  def possible_double_move?
    !@moved
  end
end
