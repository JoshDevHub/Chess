# frozen_string_literal: true

# class for managing command-line output/visuals
class Display
  def introduction
    puts 'Welcome to Chess! Press any key to begin playing > '
    gets
  end

  def print_board(board)
    system('clear')
    puts board
  end

  def piece_choice_prompt(player)
    puts "#{player}: choose the square of a piece to move :"
  end

  def move_choice_prompt(move_list)
    puts "The available moves for this piece are #{move_list}"
    puts 'Choose one'
  end

  def checkmate_message(loser, winner)
    puts "#{loser} has been checkmated."
    puts "#{winner} has won. Congratulations!"
  end

  def stalemate_message(player)
    puts "#{player} has no legal moves but is not in check"
    puts 'This is a stalemate, and this game ends in a draw.'
  end

  def promotion_message(player)
    puts "#{player}: your pawn has reached the back rank! It can promote to a new piece."
    puts 'What piece do you wish to promote to? Enter a piece using its chess notation (Q, R, B, or N)'
  end

  def input_error_message(message)
    puts({
      empty_square: 'That square is empty. Please choose an occupied square.',
      invalid_promotion_piece: "That doesn't represent a piece you can use. Input Q, R, B, or N please.",
      invalid_square: 'This square is not on the board. Use letters A-H and numbers 1-8 for your selection!',
      invalid_move: "This is an invalid move. Only choose from among this piece's legal moves",
      no_moves: "This piece doesn't have any legal moves! Please choose a different piece",
      wrong_color: 'That is not your piece. Only choose among pieces of your color.'
    }[message])
  end
end
