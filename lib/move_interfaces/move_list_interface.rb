# frozen_string_literal: true

# class for giving the user a UI that shows possible moves from a square input
class MoveListInterface < MoveInterface
  def move_selection
    return unless valid_origin?(user_input)

    move_list = board.move_list_from_origin(user_input, castle_manager)
    target = user_target_input(move_list)
    return unless target

    { origin: user_input, target: target }
  end

  private

  def user_target_input(move_list)
    loop do
      display.move_choice_prompt(move_list)
      target_input = gets.upcase.gsub(/[[:space:]]/, '')
      return delete_last_four_lines if target_input == 'BACK'

      return target_input if valid_target?(target_input, move_list)
    end
  end

  def delete_last_four_lines
    print "\r#{"\e[A\e" * 4}\e[J"
  end
end
