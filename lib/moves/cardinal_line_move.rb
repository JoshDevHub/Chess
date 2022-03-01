# frozen_string_literal: true

# class for generating cardinal line moves
class CardinalLineMove < Move
  def moveset
    [
      %i[up],
      %i[down],
      %i[left],
      %i[right]
    ]
  end

  private

  def one_step_moves?
    false
  end
end
