# frozen_string_literal: true

# class that runs the game of Chess
class Chess
  include Coordinate

  def initialize(fen_string = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    fen = FEN.new(fen_string, Piece)
    @chess_board = Board.from_fen(fen_data: fen.piece_info)
    @player_white = Player.new(color: 'white')
    @player_black = Player.new(color: 'black')
    @active_player = @player_white
  end

  # rubocop: disable Metrics/MethodLength
  def play_chess
    loop do
      puts @chess_board
      user_choice = user_piece_selection
      move_list = create_move_list(user_choice)
      puts "The available moves for this piece are: #{move_list}"
      puts 'Where would you like to move your piece?'
      chosen_move = gets.chomp
      @chess_board.move_piece(user_choice, chosen_move)
      puts @chess_board
      toggle_turns
    end
  end
  # rubocop: enable Metrics/MethodLength

  def create_move_list(piece_position)
    piece = @chess_board.piece_at(piece_position)
    initial_list = piece.move_list(@chess_board)
    @chess_board.self_check_filter(piece, initial_list)
  end

  def user_piece_selection
    loop do
      puts "#{@active_player}: choose the square of a piece to move :"
      input = gets.chomp
      return input if valid_piece_selection?(input)
    end
  end

  def toggle_turns
    @active_player =
      @active_player == @player_white ? @player_black : @player_white
  end

  def valid_piece_selection?(selection)
    if !valid_square?(selection)
      puts 'Please choose a valid sqaure!'
    elsif @chess_board.square_empty?(selection)
      puts 'That square is empty!'
    elsif @chess_board.color_at(selection) != @active_player.piece_color
      puts 'Only choose from pieces among your color!'
    else
      true
    end
  end
end
