# frozen_string_literal: true

# class to represent the concept of a chess move
class Move
  include Coordinate
  attr_reader :board

  def initialize(board:, piece:)
    @board = board
    @piece = piece
  end

  def legal_move?(move)
    valid_square?(move) && (board.square_empty?(move) || capture_move?(move))
  end

  def capture_move?(move)
    board.piece_at(move).color != @piece.color
  end
end
