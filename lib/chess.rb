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
    @active_player = fen.active_color == 'white' ? @player_white : @player_black
    @display = Display.new
    @move_interface = MoveInterface
    @castle_manager = CastleManager.new(castle_options: fen.castle_info)
  end

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def game_script
    display.introduction
    loop do
      system('clear')
      display.print_board(@chess_board)
      break unless continue_game?

      display.check_message(@active_player) if @chess_board.in_check?(active_color)
      origin, target = active_player_move.values
      moving_piece = @chess_board.access_square(origin).piece
      @castle_manager.handle_castling(moving_piece, target, @chess_board) if piece_can_affect_castling?(moving_piece)
      @chess_board.move_piece(origin, target)
      promotion_script(target)
      toggle_turns
    end
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize

  def active_player_move
    display.initial_input_prompt(@active_player)
    loop do
      input = gets.upcase.gsub(/[[:space:]]/, '')
      interface_args = { board: @chess_board, display: display, active_color: active_color,
                         user_input: input, castle_manager: @castle_manager }
      move = @move_interface.for_input(**interface_args).move_selection
      return move if move
    end
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

  def piece_can_affect_castling?(piece)
    piece.involved_in_castling? && @castle_manager.castle_rights_for_color?(active_color)
  end

  def promote_piece(fen_symbol, square)
    piece_fen = active_color == 'white' ? fen_symbol : fen_symbol.downcase
    new_piece = Piece.from_fen(piece_fen, square.name)
    square.add_piece(new_piece)
  end

  def inactive_color
    active_color == 'white' ? 'black' : 'white'
  end
end
