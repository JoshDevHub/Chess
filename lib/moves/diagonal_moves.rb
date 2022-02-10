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
    @piece.line_moves? ? continous_move(square) : one_move(square)
  end

  private

  def one_move(square)
    move_list = []
    MOVESET.each do |move|
      final_position = move.reduce(square) { |current, step| send(step, current) }
      move_list << final_position
    end
    move_list.select { |move| legal_move?(move) }
  end

  def continuous_move(square)
    # placeholder
  end
end
