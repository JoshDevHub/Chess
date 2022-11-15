# frozen_string_literal: true

# class that runs the game of Chess
class Game
  include Coordinate
  include FENSerializer

  attr_reader :display

  # rubocop: disable Metrics/ParameterLists
  # rubocop: disable Metrics/MethodLength
  def initialize(
    fen_parser: FEN,
    board: Board,
    castle_manager: CastleManager,
    piece: Piece,
    square: Square,
    display: Display.new,
    move_interface: MoveInterface,
    player_white: Player.new(color: 'white'),
    player_black: Player.new(color: 'black'),
    fen_string: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  )
    fen = fen_parser.new(fen_string, piece)
    @chess_board = board.from_fen(fen_data: fen.piece_info, square:)
    @player_white = player_white
    @player_black = player_black
    @active_color = fen.active_color
    @display = display
    @move_interface = move_interface
    @castle_manager = castle_manager.new(castle_options: fen.castle_info)
    @full_move_clock = fen.full_move_clock
    @half_move_clock = fen.half_move_clock
    @board_history_registry = []
  end
  # rubocop: enable Metrics/ParameterLists
  # rubocop: enable Metrics/MethodLength

  def play
    introduce_game
    case intro_input
    when '1'
      setup_players
      game_script
    when '2'
      load_script
    when '3'
      exit
    end
  end

  def introduce_game
    display.introduction
    display.intro_game_prompt
  end

  def intro_input
    loop do
      user_input = gets.chomp
      return user_input if ('1'..'3').cover?(user_input)

      display.input_error_message(:invalid_intro_input)
    end
  end

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def game_script
    loop do
      system('clear')
      display.print_board(@chess_board)
      break unless continue_game?

      turn_prompt
      origin, target = active_player_move.values
      moving_piece = @chess_board.access_square(origin).piece
      @castle_manager.handle_castling(moving_piece, target, @chess_board) if piece_can_affect_castling?(moving_piece)
      captured_piece = @chess_board.move_piece(origin, target)
      captured_piece.disable_castle_rights(@castle_manager)
      promotion_script(target)
      toggle_turns
      add_to_registry
      control_clocks(moving_piece, captured_piece)
    end
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize

  def turn_prompt
    display.check_message(active_player) if @chess_board.in_check?(@active_color)
    display.initial_input_prompt(active_player)
  end

  def active_player_move
    loop do
      input = gets.upcase.gsub(/[[:space:]]/, '')
      handle_save_input if input == 'SAVE'
      quit if input == 'QUIT'
      interface_args = { board: @chess_board, display:, active_color: @active_color,
                         user_input: input, castle_manager: @castle_manager }
      move = @move_interface.for_input(**interface_args).move_selection
      return move if move

      display.print_board(@chess_board)
      turn_prompt
    end
  end

  def toggle_turns
    @active_color = @active_color == 'white' ? 'black' : 'white'
  end

  # rubocop: disable Metrics/MethodLength
  def continue_game?
    if @chess_board.checkmate?(@active_color)
      display.checkmate_message(active_player, inactive_player)
    elsif @chess_board.stalemate?(@active_color)
      display.stalemate_message(@active_color)
    elsif @half_move_clock >= 50
      display.fifty_move_rule_message
    elsif threefold_repetition?
      display.draw_by_repetition_message
    else
      true
    end
  end
  # rubocop: enable Metrics/MethodLength

  def promotion_script(position)
    square = @chess_board.access_square(position)
    piece = square.piece
    return unless piece.can_promote?

    display.promotion_message(active_player)
    user_selection = take_user_promotion_input
    promote_piece(user_selection, square)
  end

  def take_user_promotion_input
    promotion_opts = %w[Q R B N]
    loop do
      user_input = gets.upcase.chomp
      return user_input if promotion_opts.include?(user_input)

      display.input_error_message(:invalid_promotion_piece)
    end
  end

  def control_clocks(moving_piece, captured_piece)
    @full_move_clock += 1 if @active_color == 'white'
    if moving_piece.move_resets_clock? || !captured_piece.absent?
      @half_move_clock = 0
    else
      @half_move_clock += 1
    end
  end

  private

  def handle_save_input
    save_game
    display.save_game_message
    exit
  end

  def quit
    display.quit_message
    exit
  end

  def setup_players
    [@player_white, @player_black].each(&:create_user_name)
  end

  def active_player
    { white: @player_white, black: @player_black }[@active_color.to_sym]
  end

  def inactive_player
    active_player == @player_white ? @player_black : @player_white
  end

  def piece_can_affect_castling?(piece)
    piece.involved_in_castling? && @castle_manager.castle_rights_for_color?(@active_color)
  end

  def promote_piece(fen_symbol, square)
    piece_fen = @active_color == 'white' ? fen_symbol : fen_symbol.downcase
    new_piece = Piece.from_fen(piece_fen, square.name)
    square.add_piece(new_piece)
  end

  def add_to_registry
    @board_history_registry << @chess_board.to_fen
  end

  def threefold_repetition?
    @board_history_registry.size - @board_history_registry.uniq.size >= 3
  end

  def inactive_color
    @active_color == 'white' ? 'black' : 'white'
  end
end
