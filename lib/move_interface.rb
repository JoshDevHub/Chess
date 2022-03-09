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

  def valid_origin?(origin)
    return false unless valid_square_name?(origin)

    square = @board.access_square(origin)
    occupied_square?(square) && piece_color_matches_player?(square) &&
      origin_contains_legal_moves?(square)
  end

  private

  def valid_square_name?(square_name)
    return true if valid_square?(square_name)

    @display.input_error_message(:invalid_square)
  end

  def occupied_square?(square)
    return true unless square.unoccupied?

    @display.input_error_message(:empty_square)
  end

  def piece_color_matches_player?(square)
    return true if square.piece_color == @active_player.piece_color

    @display.input_error_message(:wrong_color)
  end

  def origin_contains_legal_moves?(square)
    piece = square.piece
    list = piece.move_list(@board)
    legal_move_list = @board.self_check_filter(piece, list)
    return true unless legal_move_list.empty?

    @display.input_error_message(:no_moves)
  end
end
