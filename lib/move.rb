# frozen_string_literal: true

# class to represent the concept of a chess move
class Move
  include Coordinate
  attr_reader :board

  def initialize(board)
    @board = board
  end

  MOVESET = %i[moves_up? moves_down? moves_horizontally?
               line_moves? moves_diagonally? knight_moves?].freeze

  def move_list(position)
    piece = board.piece_at(position)
    return [] if piece.nil?

    MOVESET.select { |move| piece.send(move) }
    # placeholder logic
  end
end
