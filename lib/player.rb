# frozen_string_literal: true

# class for handling game's Players
class Player
  attr_reader :color

  def initialize(color:)
    @name = "Player with #{color}"
    @piece_color = color
  end

  def to_s
    @name
  end
end
