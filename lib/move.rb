# frozen_string_literal: true

# class to represent the concept of a chess move
class Move
  include Coordinate
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def move_list(position)
    # placeholder logic
  end
end
