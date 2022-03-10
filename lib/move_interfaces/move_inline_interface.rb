# frozen_string_literal: true

# class for handling movement UI for one line move inputs
class MoveInlineInterface < MoveInterface
  def move_selection
    origin = user_input[0..1]
    return unless valid_origin?(origin)

    move_list = board.move_list_from_origin(origin, castle_manager)
    target = user_input[2..3]
    return unless valid_target?(target, move_list)

    { origin: origin, target: target }
  end
end
