# frozen_string_literal: true

# class representing No Piece -- will exist on empty board squares
class NullPiece < Piece
  # rubocop: disable Lint/MissingSuper
  def initialize(*)
    @color = nil
    @name = nil
    @en_passant_target = nil
    @position = nil
  end
  # rubocop: enable Lint/MissingSuper

  def self.handles_notation?(char)
    char == '.'
  end

  def moves
    []
  end

  def move_list(_board, _castle_manager = nil)
    []
  end

  def to_s
    '   '
  end

  def opponent_color
    nil
  end

  def move_position(_target_position)
    nil
  end

  def absent?
    true
  end
end
