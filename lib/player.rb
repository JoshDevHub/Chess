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
    system('clear')
    puts "\n"
    puts "#{@name}: what would you like your player name to be?  >>"
    input = gets.strip
    @name = input
  end
end
