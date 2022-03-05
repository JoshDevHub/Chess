# frozen_string_literal: true

# class that runs the game of Chess
class Chess
  include Coordinate

  attr_reader :display

  def initialize(fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    fen = FEN.new(fen_string, Piece)
    @chess_board = Board.from_fen(fen_data: fen.piece_info, square: Square)
    @player_white = Player.new(color: 'white')
    @player_black = Player.new(color: 'black')
    @active_player = @player_white
    @display = Display.new
  end

  def play_chess
    display.introduction
    loop do
      game_loop
      break unless continue_game?
    end
    # TODO: #play_again
  end

  def game_loop
    display.print_board(@chess_board)
    user_piece_position = user_origin_selection
    user_move_selection = move_script(user_piece_position)
    @chess_board.move_piece(user_piece_position, user_move_selection)
    promotion_script(user_move_selection)
    toggle_turns
  end

  def user_origin_selection
    display.piece_choice_prompt(@active_player)
    input = take_user_square_input
    return input if valid_origin_selection?(input)

    user_origin_selection
  end

  def take_user_square_input
    loop do
      user_input = gets.chomp.upcase
      return user_input if valid_square?(user_input)

      display.input_error_message(:invalid_square)
    end
  end

  def valid_origin_selection?(selection)
    square = @chess_board.access_square(selection)
    if square.unoccupied?
      display.input_error_message(:empty_square)
    elsif square.piece_color != active_color
      display.input_error_message(:wrong_color)
    elsif create_move_list(selection).empty?
      display.input_error_message(:no_moves)
    else
      true
    end
  end

  def move_script(square)
    move_list = create_move_list(square)
    loop do
      display.move_choice_prompt(move_list)
      user_input = take_user_square_input
      return user_input if valid_move_selection?(user_input, move_list)
    end
  end

  def create_move_list(piece_position)
    square = @chess_board.access_square(piece_position)
    piece = square.piece
    initial_list = piece.move_list(@chess_board)
    @chess_board.self_check_filter(piece, initial_list)
  end

  def valid_move_selection?(selection, move_list)
    return true if move_list.include?(selection)

    display.input_error_message(:invalid_move)
  end

  def toggle_turns
    @active_player =
      @active_player == @player_white ? @player_black : @player_white
  end

  def continue_game?
    if @chess_board.checkmate?(active_color)
      display.checkmate_message(active_color, inactive_color)
    elsif @chess_board.stalemate?(active_color)
      display.stalemate_message(active_color)
    else
      true
    end
  end

  def promotion_script(position)
    square = @chess_board.access_square(position)
    piece = square.piece
    return unless piece.can_promote?

    display.promotion_message(@active_player)
    user_selection = take_user_promotion_input
    promote_piece(user_selection, square)
  end

  def take_user_promotion_input
    loop do
      user_input = gets.upcase.chomp
      return user_input if %w[Q R B N].include?(user_input)

      display.input_error_message(:invalid_promotion_piece)
    end
  end

  private

  def active_color
    @active_player.piece_color
  end

  def promote_piece(fen_symbol, square)
    piece_fen = active_color == 'white' ? fen_symbol : fen_symbol.downcase
    new_piece = Piece.from_fen(piece_fen, position.name)
    square.add_piece(new_piece)
  end

  def inactive_color
    active_color == 'white' ? 'black' : 'white'
  end
end
