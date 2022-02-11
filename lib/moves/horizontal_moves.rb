# frozen_string_literal: true

# class for managing moves to left and right or an origin
class HorizontalMoves < Move
  MOVESET = %i[left right].freeze

  def generate_moves(square)
    move_list = []
    MOVESET.each do |move|
      move_list += path_from(move, square)
    end
    move_list
  end

  private

  def path_from(move, origin)
    current_square = origin
    path = []
    loop do
      new_move = send(move, current_square)
      break unless legal_move?(new_move)

      path << new_move
      break unless @piece.line_moves?

      current_square = new_move
    end
    path
  end
end
