# frozen_string_literal: true

# class to hold logic for the chess board
class ChessBoard
  include Coordinate

  attr_reader :game_board

  def initialize(square:, fen_data:)
    @game_board = create_board(square, fen_data)
  end

  HEIGHT = 8
  WIDTH = 8

  def valid_square?(square_name)
    return false unless square_name.size == 2

    FILE_NAMES.include?(square_name[0]) && RANK_NAMES.include?(square_name[1])
  end

  private

  def create_board(square, fen_data)
    Array.new(HEIGHT) do |rank|
      Array.new(WIDTH) do |file|
        square_name = to_square_notation([file, rank])
        piece = fen_data.square_info(square_name)
        square.new(name: square_name, piece: piece)
      end
    end
  end
end
