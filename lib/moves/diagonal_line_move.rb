# frozen_string_literal: true

# subclass to generate continous diagonal moves
class DiagonalLineMove < Move
  def moveset
    [
      %i[up right],
      %i[up left],
      %i[down left],
      %i[down right]
    ]
  end

  private

  def one_step_moves?
    false
  end
end
