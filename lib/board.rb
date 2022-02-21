# frozen_string_literal: true

# class to hold logic for the chess board
class Board
  include Coordinate

  def initialize
    @game_board = Array.new(HEIGHT) { Array.new(WIDTH) }
  end

  HEIGHT = 8
  WIDTH = 8

  def self.from_fen(fen_data:)
    board = Board.new
    fen_data.each do |piece|
      piece_square = piece.position
      board.add_piece(piece, piece_square)
    end
    board
  end

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

  def add_piece(piece, square_name)
    change_board_at_square(square_name, piece)
  end

  def piece_at(square_name)
    read_board_from_square(square_name)
  end

  def color_at(square_name)
    return nil if square_empty?(square_name)

    read_board_from_square(square_name).color
  end

  def move_piece(current_square, new_square)
    return nil if square_empty?(current_square)

    piece_to_move = remove_piece(current_square)
    piece_to_move.position = new_square
    add_piece(piece_to_move, new_square)
  end

  def remove_piece(square_name)
    return nil if square_empty?(square_name)

    piece_to_remove = piece_at(square_name)
    change_board_at_square(square_name, nil)
    piece_to_remove
  end

  def square_empty?(square_name)
    read_board_from_square(square_name).nil?
  end

  def find_king(color)
    king = @game_board.flatten
                      .compact
                      .find { |piece| piece.name == 'king' && piece.color == color }
    king.position
  end

  private

  def read_board_from_square(square_name)
    x, y = to_xy_coordinate(square_name)
    @game_board[y][x]
  end

  def change_board_at_square(square_name, new_value)
    x, y = to_xy_coordinate(square_name)
    @game_board[y][x] = new_value
  end
end
