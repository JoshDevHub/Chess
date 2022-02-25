# frozen_string_literal: true

# class that runs the game of Chess
class Chess
  include Coordinate

  attr_reader :display

  def initialize(fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    fen = FEN.new(fen_string, Piece)
    @chess_board = Board.from_fen(fen_data: fen.piece_info)
    @player_white = Player.new(color: 'white')
    @player_black = Player.new(color: 'black')
    @active_player = @player_white
    @display = Display.new
  end

  def play_chess
    display.introduction
    loop do
      display.print_board(@chess_board)
      user_piece_position = user_piece_selection
      user_move = user_move_selection(user_piece_position)
      @chess_board.move_piece(user_piece_position, user_move)
      toggle_turns
    end
  end

  def create_move_list(piece_position)
    piece = @chess_board.piece_at(piece_position)
    initial_list = piece.move_list(@chess_board)
    @chess_board.self_check_filter(piece, initial_list)
  end

  def user_piece_selection
    loop do
      display.piece_choice(@active_player)
      input = gets.chomp
      return input if valid_piece_selection?(input)
    end
  end

  def valid_piece_selection?(selection)
    if !valid_square?(selection)
      display.input_error_message(:invalid_square)
    elsif @chess_board.square_empty?(selection)
      display.input_error_message(:empty_square)
    elsif @chess_board.color_at(selection) != @active_player.piece_color
      display.input_error_message(:wrong_color)
    else
      true
    end
  end

  def user_move_selection(chosen_position)
    move_list = create_move_list(chosen_position)
    loop do
      display.move_choice(move_list)
      input = gets.chomp
      return input if move_list.include?(input)

      display.input_error_message(:invalid_move)
    end
  end

  def toggle_turns
    @active_player =
      @active_player == @player_white ? @player_black : @player_white
  end
end
