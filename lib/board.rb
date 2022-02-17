# frozen_string_literal: true

# class to hold logic for the chess board
class Board
  include Coordinate

  attr_reader :game_board

  def initialize(fen_data:, piece:)
    @game_board = create_board(fen_data, piece)
  end

  HEIGHT = 8
  WIDTH = 8

  def to_s
    board_array = @game_board.flatten.map { |square| square.nil? ? ' ' : square.to_s }
    row_separator = '  |---+---+---+---+---+---+---+---|'
    board_string = ''
    board_array.each_slice(WIDTH).with_index do |row, i|
      board_string += "#{RANK_NAMES[i]} | #{row.join(' | ')} |\n#{row_separator}\n"
    end
    board_string += '    A   B   C   D   E   F   G   H  '
    board_string
  end

  def piece_at(square_name)
    x, y = to_xy_coordinate(square_name)
    game_board[y][x]
  end

  def color_at(square_name)
    return nil if square_empty?(square_name)

    x, y = to_xy_coordinate(square_name)
    game_board[y][x].color
  end

  def move_piece(current_square, new_square)
    piece_at(current_square).position = new_square
  end

  def square_empty?(square_name)
    x, y = to_xy_coordinate(square_name)
    game_board[y][x].nil?
  end

  private

  def create_board(fen_data, piece)
    Array.new(HEIGHT) do |rank|
      Array.new(WIDTH) do |file|
        square_name = to_square_notation([file, rank])
        square_fen = fen_data.square_info(square_name)
        square_fen.nil? ? square_fen : piece.from_fen(square_fen, square_name)
      end
    end
  end
end
