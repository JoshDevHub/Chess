# frozen_string_literal: true

# class for individual squares on a chess board
class Square
  def initialize(name:, occupant: nil)
    @name = name
    @occupant = occupant
  end

  def empty?
    @occupant.nil?
  end
end
