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

  def play_chess
    loop do
      puts @chess_board
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
      puts "#{@active_player}: choose the square of a piece to move :"
      input = gets.chomp
      return input if valid_piece_selection?(input)
    end
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

  def user_move_selection(chosen_position)
    move_list = create_move_list(chosen_position)
    loop do
      puts "The available moves for this piece are #{move_list}"
      puts 'Choose one'
      input = gets.chomp
      return input if move_list.include?(input)

      puts "This is an invalid move. Only choose from among this piece's legal moves"
    end
  end

  def toggle_turns
    @active_player =
      @active_player == @player_white ? @player_black : @player_white
  end
end
