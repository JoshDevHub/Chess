# frozen_string_literal: true

# subclass to generate diagonal moves
class DiagonalMoves < Move
  MOVESET = [
    %i[up right],
    %i[up left],
    %i[down left],
    %i[down right]
  ].freeze

  def generate_moves(square)
    move_list = []
    MOVESET.each do |move|
      move_list << path_from(move, square)
    end
    move_list.flatten
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
