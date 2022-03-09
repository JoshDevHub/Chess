# frozen_string_literal: true

# class for giving the user an interface for entering their desired moves
class MoveInterface
  include Coordinate

  def self.for_input(board:, display:, active_player:, user_input:)
    argument_hash = { board: board, display: display, active_player: active_player, user_input: user_input }
    case user_input.size
    when 2
      MoveListInterface.new(**argument_hash)
    when 4
      MoveInlineInterface.new(**argument_hash)
    else
      new(**argument_hash)
    end
  end

  def initialize(board:, display:, active_player:, user_input:)
    @board = board
    @display = display
    @active_player = active_player
    @user_input = user_input
  end

  def move_selection
    nil
  end
end
