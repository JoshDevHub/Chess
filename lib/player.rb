# frozen_string_literal: true

# class for handling game's Players
class Player
  attr_reader :piece_color

  def initialize(color:)
    @name = "Player with the #{color} pieces"
    @piece_color = color
  end

  def to_s
    @name
  end

  def create_user_name
    puts 'Enter your player name >>'
    input = gets.strip
    @name = input
  end
end
