# frozen_string_literal: true

# class for individual squares on a chess board
class Square
  attr_reader :name, :occupant

  def initialize(name:, occupant: nil)
    @name = name
    @occupant = occupant
  end

  def empty?
    occupant.nil?
  end

  def add_occupant(occupant)
    @occupant = occupant
  end
end
