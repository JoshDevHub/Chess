# frozen_string_literal: true

# class to hold logic for the chess board
class Board
  include Coordinate

  attr_reader :en_passant_target

  def initialize(square)
    @game_board = Array.new(HEIGHT) do |rank|
      Array.new(WIDTH) do |file|
        square_name = to_square_notation([file, rank])
        square.new(name: square_name)
      end
    end
    @en_passant_target = nil
  end

  HEIGHT = 8
  WIDTH = 8

  def self.from_fen(fen_data:, square:)
    board = Board.new(square)
    fen_data.each do |piece|
      piece_square = piece.position
      board_square = board.access_square(piece_square)
      board_square.add_piece(piece)
    end
    board
  end

  def access_square(square_name)
    @game_board.flatten.find { |square| square_name == square.name }
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

  def move_piece(current_square, new_square)
    square = access_square(current_square)
    return if square.unoccupied?

    piece_to_move = square.remove_piece
    handle_en_passant(piece_to_move, new_square)
    @en_passant_target = piece_to_move.define_en_passant_square(new_square)
    piece_to_move.position = new_square
    target_square = access_square(new_square)
    target_square.add_piece(piece_to_move)
  end

  def in_check?(color)
    king_square = find_king(color)
    opposing_color = color == 'white' ? 'black' : 'white'
    opposing_pieces = all_pieces_of_color(opposing_color)
    all_opposing_moves = opposing_pieces.map { |piece| piece.move_list(self) }.flatten
    all_opposing_moves.include?(king_square)
  end

  def checkmate?(color)
    in_check?(color) && no_legal_moves?(color)
  end

  def stalemate?(color)
    !in_check?(color) && no_legal_moves?(color)
  end

  def self_check_filter(piece, target_list)
    color = piece.color
    origin = piece.position
    target_list.reject do |target|
      board_copy = Marshal.load(Marshal.dump(self))
      board_copy.move_piece(origin, target)
      board_copy.in_check?(color)
    end
  end

  private

  def find_king(color)
    king_square = @game_board.flatten
                             .find { |square| square.occupied_by_king?(color) }
    king_square.name
  end

  def all_pieces_of_color(color)
    @game_board.flatten
               .select { |square| square.piece_color == color }
               .map(&:piece)
  end

  def no_legal_moves?(color)
    all_pieces_of_color(color).each_with_object([]) do |piece, move_list|
      moves = piece.move_list(self)
      moves_avoiding_check = self_check_filter(piece, moves)
      move_list.concat(moves_avoiding_check)
    end.empty?
  end

  def handle_en_passant(piece, target)
    return unless target == en_passant_target && piece.capture_en_passant?(target)

    capture_square_name = piece.color == 'white' ? down(target) : up(target)
    access_square(capture_square_name).remove_piece
  end
end
