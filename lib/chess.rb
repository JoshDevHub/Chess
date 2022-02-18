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
      user_choice = user_input
      move_list = @chess_board.piece_at(user_choice).generate_moves(@chess_board)
      puts "The available moves for this piece are: #{move_list}"
      puts 'Where would you like to move your piece?'
      chosen_move = gets.chomp
      @chess_board.move_piece(user_choice, chosen_move)
      puts @chess_board
      toggle_turns
    end
  end
  # rubocop: enable Metrics/MethodLength

  def user_input
    puts "#{@active_player}: choose the square of a piece to move :"
    loop do
      input = gets.chomp
      return input if valid_user_selection?(input)
    end
  end

  def toggle_turns
    @active_player =
      @active_player == @player_white ? @player_black : @player_white
  end

  def valid_user_selection?(selection)
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
