# frozen_string_literal: true

# class for managing command-line output/visuals
class Display
  def introduction
    puts 'Welcome to Chess! Press any key to begin playing > '
    gets
  end

  def print_board(board)
    puts board
  end

  def piece_choice(player)
    puts "#{player}: choose the square of a piece to move :"
  end

  def move_choice(move_list)
    puts "The available moves for this piece are #{move_list}"
    puts 'Choose one'
  end

  def input_error_message(message)
    puts({
      empty_square: 'That square is empty. Please choose an occupied square.',
      invalid_square: 'This square is not on the board. Use letters A-H and numbers 1-8 for your selection!',
      invalid_move: "This is an invalid move. Only choose from among this piece's legal moves",
      wrong_color: 'That is not your piece. Only choose among pieces of your color.'
    }[message])
  end
end
