# frozen_string_literal: true

require_relative 'square'

# class to hold logic for the chess board
class ChessBoard
  attr_reader :game_board

  def initialize(square)
    @game_board = create_board(square)
  end

  HEIGHT = 8
  WIDTH = 8

  FILE_NAMES = %w[A B C D E F G H].freeze
  RANK_NAMES = %w[1 2 3 4 5 6 7 8].freeze

  private

  def create_board(square)
    Array.new(HEIGHT) do |rank|
      Array.new(WIDTH) do |file|
        square_name = FILE_NAMES[file] + RANK_NAMES[rank]
        square.new(name: square_name)
      end
    end
  end
end
