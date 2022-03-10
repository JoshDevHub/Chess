# frozen_string_literal: true

# class for giving the user an interface for entering their desired moves
class MoveInterface
  include Coordinate

  def self.for_input(board:, display:, active_color:, castle_manager:, user_input:)
    argument_hash = { board: board, display: display, active_color: active_color,
                      castle_manager: castle_manager, user_input: user_input }
    case user_input.size
    when 2
      MoveListInterface.new(**argument_hash)
    when 4
      MoveInlineInterface.new(**argument_hash)
    else
      new(**argument_hash)
    end
  end

  def initialize(board:, display:, active_color:, castle_manager:, user_input:)
    @board = board
    @display = display
    @active_color = active_color
    @user_input = user_input
    @castle_manager = castle_manager
  end

  def move_selection
    display.input_error_message(:invalid_initial_input)
  end

  def valid_origin?(origin)
    return false unless valid_square_name?(origin)

    square = @board.access_square(origin)
    validators.all? { |validator| send(validator, square) }
  end

  def valid_target?(target, target_list)
    return true if target_list.include?(target)

    @display.input_error_message(:invalid_move)
  end

  private

  attr_reader :board, :display, :active_color, :user_input, :castle_manager

  def validators
    %i[
      occupied_square?
      piece_color_matches_player?
      origin_contains_legal_moves?
    ]
  end

  def valid_square_name?(square_name)
    return true if valid_square?(square_name)

    @display.input_error_message(:invalid_square)
  end

  def occupied_square?(square)
    return true unless square.unoccupied?

    @display.input_error_message(:empty_square)
  end

  def piece_color_matches_player?(square)
    return true if square.piece_color == @active_color

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
