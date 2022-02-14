# frozen_string_literal: true

# Move subclass that generates Knight Moves
class KnightMove < Move
  MOVESET = [
    %i[up up right],
    %i[up up left],
    %i[down down right],
    %i[down down left],
    %i[left left up],
    %i[left left down],
    %i[right right up],
    %i[right right down]
  ].freeze

  # def generate_moves(square)
  #   move_list = []
  #   MOVESET.each do |move|
  #     final_position = move.reduce(square) { |current, step| send(step, current) }
  #     move_list << final_position
  #   end
  #   move_list.select { |move| legal_move?(move) }
  # end
end
