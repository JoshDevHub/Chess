# frozen_string_literal: true

# class for managing command-line output/visuals
class Display
  def introduction
    system('clear')
    puts <<~HEREDOC
      Welcome to Chess!

      Press any key to continue >>
    HEREDOC
    gets
  end

  def intro_game_prompt
    system('clear')
    puts <<~HEREDOC
      Press [1] to start a new game.
      Press [2] to load a saved game.
      Press [3] to exit.
    HEREDOC
  end

  def load_game_prompt(save_list)
    system('clear')
    puts "\nSave Games:\n\n"
    save_list.sort.each { |save_file| puts "#{save_file[0..-6].gsub('_', ' ')}\n" }
    puts <<~HEREDOC

      Enter the number of the game you wish to resume
    HEREDOC
  end

  def print_board(board)
    system('clear')
    puts "\n\n"
    puts board
    puts "\n"
  end

  def check_message(player)
    puts <<~HEREDOC
      #{player}, your king is under attack!
      You next move must escape check.\n
    HEREDOC
  end

  def initial_input_prompt(player)
    puts <<~HEREDOC
      #{player}: it's your turn to move a piece.

        You can enter an origin square and target square in one line OR
        You can enter an origin square and see a list of moves to pick from.

      Enter your choice  >>
    HEREDOC
  end

  def save_game_message
    puts <<~HEREDOC

      Your game has been saved.
      Thanks for playing!
    HEREDOC
  end

  def move_choice_prompt(board, move_list)
    system('clear')
    puts "\n\n"
    puts board.to_s(:to_string_with_moves, move_list)
    puts "\n"
    display_list = array_to_readable_list(move_list)
    puts <<~HEREDOC
      The available moves for this piece are #{display_list}
      Choose a move or type 'back' to exit and choose another piece >>
    HEREDOC
  end

  def checkmate_message(loser, winner)
    puts <<~HEREDOC
      #{loser} has been checkmated.
      #{winner} has won the game. Congratulations!
    HEREDOC
  end

  def stalemate_message(player)
    puts <<~HEREDOC
      #{player} has no legal moves but is not in check.
      This is a stalemat, and the game ends in a draw.
    HEREDOC
  end

  def fifty_move_rule_message
    puts <<~HEREDOC
      It has been fifty moves since the last pawn advance
      or piece capture. This activates the 'fifty move rule',
      and the game will end in a draw.
    HEREDOC
  end

  def draw_by_repetition_message
    puts <<~HEREDOC
      This board position has been repeated three times.
      The game ends in a draw by three-fold repetition.
    HEREDOC
  end

  def promotion_message(player)
    puts <<~HEREDOC
      #{player}: your pawn has reached the back rank! It can now promote to a new piece.

      Enter the piece you wish to promote to using its chess notation:
        Q for Queen
        R for Rook
        B for Bishop
        N for Knight
    HEREDOC
  end

  def input_error_message(message)
    print({
      empty_square: 'That square is empty. Please choose an occupied square.',
      invalid_initial_input: 'Unable to parse that input. Please use one of the two valid formats',
      invalid_intro_input: 'Please only use numbers 1, 2, or 3 to make your choice.',
      invalid_promotion_piece: "That doesn't represent a piece you can use. Input Q, R, B, or N please.",
      invalid_square: 'This square is not on the board. Use letters A-H and numbers 1-8 for your selection!',
      invalid_move: "This is an invalid move. Only choose from among this piece's legal moves",
      no_moves: "This piece doesn't have any legal moves! Please choose a different piece",
      save_number: 'That input does not correspond to any of the save files. Choose again.',
      wrong_color: 'That is not your piece. Only choose among pieces of your color.'
    }[message])
    sleep(2.5)
    delete_display_lines(1)
  end

  def delete_display_lines(number_of_lines)
    print "\r#{"\e[A\e" * number_of_lines}\e[J"
  end

  private

  def array_to_readable_list(array)
    case array.size
    when 1
      array.join
    when 2
      array.join(' and ')
    else
      [array[0..-2].join(', '), array.last].join(', and ')
    end
  end
end
