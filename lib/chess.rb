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
      break unless continue_game?

      user_piece_position = user_origin_selection
      user_move = user_target_selection(user_piece_position)
      @chess_board.move_piece(user_piece_position, user_move)
      promotion_script(user_move)
      toggle_turns
    end
  end

  def create_move_list(piece_position)
    piece = @chess_board.piece_at(piece_position)
    initial_list = piece.move_list(@chess_board)
    @chess_board.self_check_filter(piece, initial_list)
  end

  def user_origin_selection
    loop do
      display.piece_choice(@active_player)
      input = user_square_input
      return input if valid_origin_selection?(input)
    end
  end

  def valid_origin_selection?(selection)
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

  def user_target_selection(chosen_position)
    move_list = create_move_list(chosen_position)
    loop do
      display.move_choice(move_list)
      input = user_square_input
      return input if move_list.include?(input)

      display.input_error_message(:invalid_move)
    end
  end

  def toggle_turns
    @active_player =
      @active_player == @player_white ? @player_black : @player_white
  end

  def continue_game?
    if @chess_board.checkmate?(active_color)
      display.checkmate(active_color, inactive_color)
    elsif @chess_board.stalemate?(active_color)
      display.stalemate(active_color)
    else
      true
    end
  end

  def promotion_script(square)
    return unless @chess_board.piece_at(square).can_promote?

    user_selection = promotion_piece_selection
    new_piece = Piece.from_fen(user_selection, square)
    @chess_board.add_piece(new_piece, square)
  end

  def promotion_piece_selection
    loop do
      display.promotion_message(@active_player)
      selection = gets.chomp.upcase
      return selection if valid_promotion_piece_selection?(selection)

      display.input_error_message(:invalid_piece)
    end
  end

  def valid_promotion_piece_selection?(selection)
    %w[Q R B N].include?(selection)
  end

  private

  def active_color
    @active_player.piece_color
  end

  def promote_piece(fen_symbol, position)
    piece_fen = active_color == 'white' ? fen_symbol : fen_symbol.downcase
    new_piece = Piece.from_fen(piece_fen, position)
    @chess_board.add_piece(new_piece, position)
  end

  def user_square_input
    gets.chomp.upcase
  end

  def inactive_color
    active_color == 'white' ? 'black' : 'white'
  end
end
